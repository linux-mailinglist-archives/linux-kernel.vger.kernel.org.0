Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5082F9B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 22:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 16:01:09 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53247 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfKLVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:01:09 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xACL0gLr095467;
        Wed, 13 Nov 2019 06:00:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Wed, 13 Nov 2019 06:00:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040052248.bbtec.net [126.40.52.248])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xACL0bKE095449
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Nov 2019 06:00:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in aa_sock_msg_perm (2)
To:     syzbot <syzbot+e3b328542d4adc02a975@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000004471505972a9432@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Message-ID: <f291704f-464d-72f2-b016-0073bc6a8ac3@I-love.SAKURA.ne.jp>
Date:   Wed, 13 Nov 2019 06:00:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <00000000000004471505972a9432@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/rxrpc/output.c:655 was previously reported as "#syz dup: KASAN: use-after-free Read in rxrpc_send_keepalive".
Now reported as different subject?

#syz dup: KMSAN: use-after-free in rxrpc_send_keepalive

