Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65FC4711F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfFOQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 12:00:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54978 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFOQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 12:00:44 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5FFxdWl046712;
        Sun, 16 Jun 2019 00:59:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Sun, 16 Jun 2019 00:59:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5FFxYoZ046678
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 16 Jun 2019 00:59:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in oom_unkillable_task
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, mhocko@kernel.org
Cc:     ebiederm@xmission.com, guro@fb.com, hannes@cmpxchg.org,
        jglisse@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, yuzhoujian@didichuxing.com
References: <0000000000004143a5058b526503@google.com>
 <cc3d5247-855d-a124-041f-64c4659d95c3@i-love.sakura.ne.jp>
Message-ID: <8c50ca8c-3869-6f50-3a3f-bc7726c39975@i-love.sakura.ne.jp>
Date:   Sun, 16 Jun 2019 00:59:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <cc3d5247-855d-a124-041f-64c4659d95c3@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/15 10:10, Tetsuo Handa wrote:
> I'm not sure this patch is correct/safe. Can you try memcg OOM torture
> test (including memcg group OOM killing enabled) with this patch applied?

Well, I guess this patch was wrong. The ordering of removing threads
does not matter as long as we start traversing via signal_struct.
The reason why crashed at for_each_thread() is unknown...

