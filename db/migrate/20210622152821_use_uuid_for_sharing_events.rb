class UseUuidForSharingEvents < ActiveRecord::Migration[6.1]
  def up
    enable_extension "pgcrypto"

    add_column :sharing_events, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :documents_sharing_events, :sharing_event_uuid, :uuid

    execute <<~SQL
      UPDATE documents_sharing_events
      SET sharing_event_uuid = sharing_events.uuid
      FROM sharing_events
      WHERE documents_sharing_events.sharing_event_id = sharing_events.id
    SQL

    change_column_null :documents_sharing_events, :sharing_event_uuid, false

    remove_column :documents_sharing_events, :sharing_event_id
    rename_column :documents_sharing_events, :sharing_event_uuid, :sharing_event_id
    add_index :documents_sharing_events, :sharing_event_id

    remove_column :sharing_events, :id
    rename_column :sharing_events, :uuid, :id
    add_index :sharing_events, :id
    execute "ALTER TABLE sharing_events ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
