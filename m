Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0C1260E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 12:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLSLeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 06:34:23 -0500
Received: from nautica.notk.org ([91.121.71.147]:40169 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfLSLeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:34:22 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 93699C009; Thu, 19 Dec 2019 12:34:21 +0100 (CET)
Date:   Thu, 19 Dec 2019 12:34:06 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] 9p: Remove unneeded semicolon
Message-ID: <20191219113406.GA22811@nautica>
References: <1576752517-58292-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576752517-58292-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhengbin wrote on Thu, Dec 19, 2019:
> Fixes coccicheck warning:
> 
> fs/9p/vfs_inode.c:146:3-4: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Taken, will be in linux-next in the next few days.

Please note I won't submit a pull request to Linus if I only have this
so it might take an extra couple of months to get in depending on what
patches get sent.

-- 
Dominique
