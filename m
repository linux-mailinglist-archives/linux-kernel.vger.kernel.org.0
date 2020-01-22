Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5C145B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 19:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAVScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 13:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:40872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVScJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:32:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA74FADE3;
        Wed, 22 Jan 2020 18:32:05 +0000 (UTC)
Date:   Wed, 22 Jan 2020 10:25:11 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alexey Mateosyan <alexey.mateosyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Li Rongqing <lirongqing@baidu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mq_notify loose notification request on fork()
Message-ID: <20200122182511.uf4x6q5t5zelwi3g@linux-p48b>
References: <CACdZwvBEsS__hiWyMGina9R3A0PUbrCD5pV2+B9Bgy65joXj5g@mail.gmail.com>
 <20200121185250.fk6nkcw5nqbkab5o@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200121185250.fk6nkcw5nqbkab5o@linux-p48b>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020, Bueso wrote:
>diff --git a/fs/file.c b/fs/file.c
>index 2f4fcf985079..70e5fe1c70d5 100644
>--- a/fs/file.c
>+++ b/fs/file.c
>@@ -440,6 +440,7 @@ void exit_files(struct task_struct *tsk)
>
>	if (files) {
>		task_lock(tsk);
>+		files->tsk = NULL;

This part is wrong, of course, as we later need it. We can just remove
that statement.

Thanks,
Davidlohr
