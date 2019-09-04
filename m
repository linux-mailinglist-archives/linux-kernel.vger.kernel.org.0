Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369FCA802C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfIDKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:16:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53517 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfIDKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:16:41 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84AGEi7062946;
        Wed, 4 Sep 2019 19:16:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 04 Sep 2019 19:16:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84AGEGF062937
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 19:16:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: general protection fault in smack_socket_sendmsg
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
References: <20190831053311.15704-1-hdanton@sina.com>
 <5f34b914-ca5b-e527-9183-64dc0d83ec9f@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <b2a7cbb6-2243-d591-41e7-955e1e1e4785@I-love.SAKURA.ne.jp>
Date:   Wed, 4 Sep 2019 19:16:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5f34b914-ca5b-e527-9183-64dc0d83ec9f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/04 8:17, Casey Schaufler wrote:
> On 8/30/2019 10:33 PM, Hillf Danton wrote:
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=5fd781d646d4fcbdfeb0
> If you want to add a description and signed-off-by I will take this.

Excuse me, but this bug was already closed as dup of "KASAN: use-after-free Read in rxrpc_send_keepalive".

