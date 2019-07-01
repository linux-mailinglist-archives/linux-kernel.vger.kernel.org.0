Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74C5C114
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfGAQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 12:26:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35276 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfGAQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:26:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhz8Q-00021O-6h; Mon, 01 Jul 2019 16:26:30 +0000
Date:   Mon, 1 Jul 2019 17:26:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com,
        jannh@google.com, akpm@linux-foundation.org, arunks@codeaurora.org,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        gregkh@linuxfoundation.org, guro@fb.com, ktsanaktsidis@zendesk.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com, rppt@linux.vnet.ibm.com,
        scuttimmy@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org, yuehaibing@huawei.com
Subject: Re: [PATCH] fork: return proper negative error code
Message-ID: <20190701162629.GZ17978@ZenIV.linux.org.uk>
References: <000000000000e0dc0d058c9e7142@google.com>
 <20190701144808.6804-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701144808.6804-1-christian@brauner.io>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:48:08PM +0200, Christian Brauner wrote:
> Make sure to return a proper negative error code from copy_process()
> when anon_inode_getfile() fails with CLONE_PIDFD.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
