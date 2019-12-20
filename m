Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE87127B33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 13:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 07:39:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfLTMjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:39:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9110AE47;
        Fri, 20 Dec 2019 12:39:34 +0000 (UTC)
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20191209201444.33243-1-natechancellor@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f915e97e-e395-7ef5-0971-1b6088cc4a6a@suse.com>
Date:   Fri, 20 Dec 2019 13:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209201444.33243-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 21:14, Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>                  nr_parts = PARTS_PER_DISK;
>                  ^
> ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
>                  if (err)
>                  ^
> 
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
> 
> While we are here, the previous line has some trailing whitespace; clean
> that up as well.
> 
> Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
> Link: https://github.com/ClangBuiltLinux/linux/issues/791
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Pushed to xen/tip.git for-linus-5.5b


Juergen
