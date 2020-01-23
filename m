Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0311460A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 03:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 21:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWCNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:13:48 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEFE24125;
        Thu, 23 Jan 2020 02:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579745628;
        bh=UVtHGuBwD4NKnOj+Kfsya+kpYb2Ei7ghhepkkktbhCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDZDIFzZTL682ulrwViKOe3ewyQMdqkVmdmvds4xrpPq8JiU9RfR7qcpjFRab+o8R
         PiUYSZiGGtYjMeFGuBcGEK/Qsg/TCaVD+tNFJWPm5ZNhjNF2928EPwaguDVdEh+cr6
         6tmFC6YDE4ITDDWouK47F3UXSqAHzvvr2BLnLGfM=
Date:   Wed, 22 Jan 2020 18:13:46 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
Message-ID: <20200123021346.GA862@sol.localdomain>
References: <20200123011354.75282-1-jaegeuk@kernel.org>
 <20200123011354.75282-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123011354.75282-2-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:13:54PM -0800, Jaegeuk Kim wrote:
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index ce2936554ef8..7565ba9967dd 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -150,7 +150,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  /*
>   * This function calculates BDF of every segments
>   */
> -static void update_sit_info(struct f2fs_sb_info *sbi)
> +void update_sit_info(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_stat_info *si = F2FS_STAT(sbi);
>  	unsigned long long blks_per_sec, hblks_per_sec, total_vblocks;

Global functions need a "f2fs_" prefix.

- Eric
