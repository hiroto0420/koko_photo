class ImageUploadJob < ApplicationJob
  queue_as :default

  def perform(record_class, record_id, blob_id)
    record = record_class.constantize.find(record_id)
    blob = ActiveStorage::Blob.find(blob_id)

    record.images.attach(blob)
  end
end
