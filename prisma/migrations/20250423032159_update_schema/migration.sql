/*
  Warnings:

  - The `profilePic` column on the `Author` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `videoUrl` column on the `Video` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Author" DROP COLUMN "profilePic",
ADD COLUMN     "profilePic" TEXT[];

-- AlterTable
ALTER TABLE "Video" DROP COLUMN "videoUrl",
ADD COLUMN     "videoUrl" TEXT[];
