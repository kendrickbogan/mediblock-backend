class UseBigIntForSharingEventPk < ActiveRecord::Migration[6.1]
  def up
    add_column :sharing_events, :uuid, :uuid
    add_column :documents_sharing_events, :sharing_event_uuid, :uuid
    add_column :sharing_event_codes, :sharing_event_uuid, :uuid

    execute <<~SQL
      UPDATE sharing_events SET uuid = id
    SQL

    change_column_null :sharing_events, :uuid, false
    add_index :sharing_events, :uuid

    execute <<~SQL
      UPDATE documents_sharing_events SET sharing_event_uuid = sharing_event_id
    SQL

    execute <<~SQL
      UPDATE sharing_event_codes SET sharing_event_uuid = sharing_event_id
    SQL

    remove_column :sharing_event_codes, :sharing_event_id
    remove_column :documents_sharing_events, :sharing_event_id
    remove_column :sharing_events, :id

    add_column :sharing_events, :id, :primary_key, index: true
    add_column :documents_sharing_events, :sharing_event_id, :bigint
    add_column :sharing_event_codes, :sharing_event_id, :bigint

    execute <<~SQL
      UPDATE documents_sharing_events
      SET sharing_event_id = sharing_events.id
      FROM sharing_events
      WHERE documents_sharing_events.sharing_event_uuid = sharing_events.uuid
    SQL

    execute <<~SQL
      UPDATE sharing_event_codes
      SET sharing_event_id = sharing_events.id
      FROM sharing_events
      WHERE sharing_event_codes.sharing_event_uuid = sharing_events.uuid
    SQL

    change_column_null :documents_sharing_events, :sharing_event_id, false
    change_column_null :sharing_event_codes, :sharing_event_id, false
    add_index :documents_sharing_events, :sharing_event_id
    add_index :sharing_event_codes, :sharing_event_id
    add_foreign_key :documents_sharing_events, :sharing_events
    add_foreign_key :sharing_event_codes, :sharing_events

    remove_column :documents_sharing_events, :sharing_event_uuid
    remove_column :sharing_event_codes, :sharing_event_uuid

    change_column_default :sharing_events, :uuid, "gen_random_uuid()"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
