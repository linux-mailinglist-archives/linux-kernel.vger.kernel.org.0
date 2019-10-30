Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CCEA435
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfJ3T0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 15:26:36 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35269 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfJ3T0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:26:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iPtby-000758-Jv; Wed, 30 Oct 2019 13:26:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iPtbx-0007ls-C9; Wed, 30 Oct 2019 13:26:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
References: <20191029182320.GA17569@mwanda>
        <87zhhjjryk.fsf@x220.int.ebiederm.org> <20191030074321.GD2656@xps-13>
Date:   Wed, 30 Oct 2019 14:26:21 -0500
In-Reply-To: <20191030074321.GD2656@xps-13> (Andrea Righi's message of "Wed,
        30 Oct 2019 08:43:21 +0100")
Message-ID: <87r22ujaqq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iPtbx-0007ls-C9;;;mid=<87r22ujaqq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FbjDNGFR7y0rdUnCUnTTvGuw2gDijzYQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4389]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrea Righi <andrea.righi@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 731 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.1 (0.3%), parse: 1.60
        (0.2%), extract_message_metadata: 14 (1.9%), get_uri_detail_list: 1.61
        (0.2%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 26 (3.6%), check_bayes: 25
        (3.4%), b_tokenize: 8 (1.1%), b_tok_get_all: 8 (1.1%), b_comp_prob:
        2.6 (0.4%), b_tok_touch_all: 3.1 (0.4%), b_finish: 0.69 (0.1%),
        tests_pri_0: 659 (90.2%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 10 (1.3%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 12 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Tue, Oct 29, 2019 at 02:02:11PM -0500, Eric W. Biederman wrote:
>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>> 
>> > The "fix" struct has a 2 byte hole after ->ywrapstep and the
>> > "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
>> > on the compiler.
>> >
>> > Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> > ---
>> > I have 13 more similar places to patch...  I'm not totally sure I
>> > understand all the issues involved.
>> 
>> What I have done in a similar situation with struct siginfo, is that
>> where the structure first appears I have initialized it with memset,
>> and then field by field.
>> 
>> Then when the structure is copied I copy the structure with memcpy.
>> 
>> That ensures all of the bytes in the original structure are initialized
>> and that all of the bytes are copied.
>> 
>> The goal is to avoid memory that has values of the previous users of
>> that memory region from leaking to userspace.  Which depending on who
>> the previous user of that memory region is could tell userspace
>> information about what the kernel is doing that it should not be allowed
>> to find out.
>> 
>> I tried to trace through where "info" and thus presumably "info->fix" is
>> coming from and only made it as far as  register_framebuffer.  Given
>> that I suspect a local memset, and then a field by field copy right
>> before copy_to_user might be a sound solution.  But ick.  That is a lot
>> of fields to copy.
>
> I know it might sound quite inefficient, but what about making struct
> fb_fix_screeninfo __packed?
>
> This doesn't solve other potential similar issues, but for this
> particular case it could be a reasonable and simple fix.

It is part of the user space ABI.  As such you can't move the fields.

Eric
