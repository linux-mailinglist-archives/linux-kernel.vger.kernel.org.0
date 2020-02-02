Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB814FC58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBBJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 04:01:29 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50596 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgBBJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 04:01:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tox1Zpm_1580634085;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tox1Zpm_1580634085)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Feb 2020 17:01:25 +0800
Subject: Re: [PATCH] ocfs2: remove trivial nowait check for buffered
 read/write
To:     qiwuchen55@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        trivial@kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
References: <1580541178-7853-1-git-send-email-qiwuchen55@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <64ca27c4-c3ee-2a43-3d97-35ad55e11472@linux.alibaba.com>
Date:   Sun, 2 Feb 2020 17:01:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1580541178-7853-1-git-send-email-qiwuchen55@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/2/1 15:12, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Remove trivial nowait check for buffered read/write, since
> buffered read is checked in generic_file_read_iter()->
> generic_file_buffered_read(), buffered write is checked in
> generic_write_checks().
> 
You are right, but check it at the beginning of
ocfs2_file_[read|write]_iter() will save much effort for lock ops, so
I'd like to leave them there.

Thanks,
Joseph
