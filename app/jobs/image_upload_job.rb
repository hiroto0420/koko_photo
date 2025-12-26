class ImageUploadJob < ApplicationJob
  queue_as :default

  def perform(record_class, record_id, blob_id)
    record = record_class.constantize.find(record_id)
    blob = ActiveStorage::Blob.find(blob_id)

    record.images.attach(blob)

    Rails.logger.info "ImageUploadJob processed for record #{record_id}, blob #{blob_id}"
  end
end
