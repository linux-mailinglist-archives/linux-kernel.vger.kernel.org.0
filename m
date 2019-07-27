Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F012D77B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfG0Sn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 14:43:29 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50694 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbfG0Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:43:29 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hrRfC-0007bk-MS; Sat, 27 Jul 2019 20:43:26 +0200
Message-ID: <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] devcoredump: fix typo in comment
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date:   Sat, 27 Jul 2019 20:43:21 +0200
In-Reply-To: <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com> (sfid-20190727_180021_560209_E209497F)
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
         <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
         (sfid-20190727_180021_560209_E209497F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-28 at 00:59 +0900, Akinobu Mita wrote:
> s/dev_coredumpmsg/dev_coredumpsg/

Oops, thanks

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Greg, I think before you took these patches?

Thanks,
johannes

