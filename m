Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07224188D93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCQTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 15:01:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42802 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:01:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jEHSg-0006KJ-Be; Tue, 17 Mar 2020 13:01:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jEHSf-0007gi-Em; Tue, 17 Mar 2020 13:01:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Simon Ser <contact@emersion.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg\@redhat.com" <oleg@redhat.com>,
        "christian\@brauner.io" <christian@brauner.io>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
Date:   Tue, 17 Mar 2020 13:58:46 -0500
In-Reply-To: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
        (Simon Ser's message of "Tue, 17 Mar 2020 17:54:47 +0000")
Message-ID: <87d09akduh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jEHSf-0007gi-Em;;;mid=<87d09akduh.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+F15h1WKqYx5MbXi45XLT/2BZ2Do4QVqM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4906]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Simon Ser <contact@emersion.fr>
X-Spam-Relay-Country: 
X-Spam-Timing: total 481 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.2 (0.7%), b_tie_ro: 2.1 (0.4%), parse: 1.51
        (0.3%), extract_message_metadata: 24 (4.9%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 21 (4.4%), tests_pri_-950: 1.87 (0.4%),
        tests_pri_-900: 1.51 (0.3%), tests_pri_-90: 34 (7.0%), check_bayes: 31
        (6.5%), b_tokenize: 11 (2.3%), b_tok_get_all: 7 (1.5%), b_comp_prob:
        3.2 (0.7%), b_tok_touch_all: 4.5 (0.9%), b_finish: 0.73 (0.2%),
        tests_pri_0: 297 (61.8%), check_dkim_signature: 0.85 (0.2%),
        check_dkim_adsp: 12 (2.5%), poll_dns_idle: 80 (16.7%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 90 (18.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: SO_PEERCRED and pidfd
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Ser <contact@emersion.fr> writes:

> Hi all,
>
> I'm a Wayland developer and I've been working on protocol security,
> which involves identifying the process on the other end of a Unix
> socket [1]. This is already done by e.g. D-Bus via the PID, however
> this is racy [2].
>
> Getting the PID is done via SO_PEERCRED. Would there be interest in
> adding a way to get a pidfd out of a Unix socket to fix the race?

I think we are passing a struct pid through the socket metadata.
So it should be technically feasible.

However it does come with some long term mainteance costs.

The big question is what is a pid being used for when being passed.
Last I looked most of the justifications for using metadata like that
with unix domain sockets led to patterns of trust that were also
exploitable.

Looking at the proposale in [1] even if you have race free access
to /proc/<pid>/exe using pidfds it is possible to change /proc/<pid>/exe
to be anything you can map so that seems to be an example of a problem.

So it would be very nice to see a use case spelled out where
the pid reuse race mattered, and that trusting a pid makes sense.


I have to dash but I will think about this and see if I can give a
concrete example of using a capability model.  Other than the current
one that works (handing out trusted sockets at the logical beginning of
time).  Though frankly I am not certain there is anything much better
than that.

Eric






> Thanks,
>
> Simon Ser
>
> [1]: https://gitlab.freedesktop.org/wayland/weston/issues/206
> [2]: https://github.com/flatpak/flatpak/issues/2995
