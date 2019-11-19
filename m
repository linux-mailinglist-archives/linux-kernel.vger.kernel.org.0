Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDF102505
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 13:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfKSM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 07:58:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfKSM6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:58:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF8BFB1DC;
        Tue, 19 Nov 2019 12:58:23 +0000 (UTC)
Subject: Ping: [PATCH 0/2] x86/Xen/32: xen_iret_crit_fixup adjustments
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Message-ID: <09359c00-5769-0e0d-4af9-963897d3b498@suse.com>
Date:   Tue, 19 Nov 2019 13:58:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.2019 15:30, Jan Beulich wrote:
> The first patch here fixes another regression from 3c88c692c287
> ("x86/stackframe/32: Provide consistent pt_regs"), besides the
> one already addressed by
> https://lists.xenproject.org/archives/html/xen-devel/2019-10/msg01988.html.
> The second patch is a minimal bit of cleanup on top.
> 
> 1: make xen_iret_crit_fixup independent of frame layout
> 2: simplify xen_iret_crit_fixup's ring check

Seeing that the other regression fix has been taken into -tip,
what is the situation here? Should 5.4 really ship with this
still unfixed?

Jan
