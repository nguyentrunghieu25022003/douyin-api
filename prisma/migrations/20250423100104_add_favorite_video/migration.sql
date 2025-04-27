-- CreateTable
CREATE TABLE "FavoriteVideo" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "videoId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FavoriteVideo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FavoriteVideo_userId_videoId_key" ON "FavoriteVideo"("userId", "videoId");

-- AddForeignKey
ALTER TABLE "FavoriteVideo" ADD CONSTRAINT "FavoriteVideo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavoriteVideo" ADD CONSTRAINT "FavoriteVideo_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES "Video"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
