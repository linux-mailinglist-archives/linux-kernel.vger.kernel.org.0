Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA186D0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbfGRPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGRPBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3104A3B5F;
        Thu, 18 Jul 2019 15:01:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CAC5605B1;
        Thu, 18 Jul 2019 15:00:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Jul 2019 17:01:02 +0200 (CEST)
Date:   Thu, 18 Jul 2019 17:00:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190718150057.GB13355@redhat.com>
References: <20190717172100.261204-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717172100.261204-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 18 Jul 2019 15:01:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17, Joel Fernandes (Google) wrote:
>
> exit_notify
>   do_notify_parent
>     do_notify_pidfd
>   tsk->exit_state = EXIT_DEAD

OOPS. Somehow I thought it sets exit_state before do_notify_parent(),
I didn't even bother to verify this when I reviewed pidfd_poll()...

Sorry, can't read the patch today, will do tomorrow.

Oleg.

