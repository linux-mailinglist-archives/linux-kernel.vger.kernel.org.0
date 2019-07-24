Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8617251D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfGXDJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 23:09:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58569 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGXDJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:09:10 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6O392Oa034697;
        Wed, 24 Jul 2019 12:09:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Wed, 24 Jul 2019 12:09:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6O392fX034691
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 24 Jul 2019 12:09:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kexec: Bail out upon SIGKILL when allocating memory.
To:     Eric Biederman <ebiederm@xmission.com>
References: <000000000000a861f6058b2699e0@google.com>
 <000000000000c0103a058b2ba0ec@google.com>
 <993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp>
 <20190724025422.GQ643@sol.localdomain>
Cc:     syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <21e9b463-7a10-4168-f08c-33653ea32767@i-love.sakura.ne.jp>
Date:   Wed, 24 Jul 2019 12:09:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724025422.GQ643@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/24 11:54, Eric Biggers wrote:
> 
> What happened to this patch?  This bug is still occurring.

Andrew Morton added this patch to the -mm tree.
Should appear in the linux-next tree in a few days.

https://marc.info/?l=linux-mm-commits&m=156391134729795&w=2
