Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2E145BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAVSjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 13:39:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726205AbgAVSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579718363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXqpEpNaHdzyxb5AsLGKkFd0SaAT+fBnVPbAH2nV/jM=;
        b=YdiRBwidpxEfsgy8SrXD6Yd7fcPtI+ow4OWiVAOfhFI/1+p05MNA0F+SKQQzSHISU1DlaB
        fFu2y4Xh5Ze0lOlMAVe1HELNZIyjGFMf6G285GSxrGaEzf6Kmo9fLlp22HByEkXsg5CaUh
        Fw+jhRRC9uDzZ+14kNGJL/xfO/fG1Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-vdZbZsgzNBGhY_r9lCRySQ-1; Wed, 22 Jan 2020 13:39:19 -0500
X-MC-Unique: vdZbZsgzNBGhY_r9lCRySQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C343100550E;
        Wed, 22 Jan 2020 18:39:17 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7664519C5B;
        Wed, 22 Jan 2020 18:39:15 +0000 (UTC)
Message-ID: <56d00d663e61abf7df7cdd91d8da98b4f9e5906e.camel@redhat.com>
Subject: Re: [PATCH RT 24/32] sched: migrate_enable: Use
 stop_one_cpu_nowait()
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Wed, 22 Jan 2020 12:39:14 -0600
In-Reply-To: <20200122063311.52b68472@gandalf.local.home>
References: <20200117174111.282847363@goodmis.org>
         <20200117174131.019724236@goodmis.org>
         <20200122083130.kuu3yppckhyjrr4u@linutronix.de>
         <20200122063311.52b68472@gandalf.local.home>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-22 at 06:33 -0500, Steven Rostedt wrote:
> On Wed, 22 Jan 2020 09:31:30 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2020-01-17 12:41:35 [-0500], Steven Rostedt wrote:
> > > 4.19.94-rt39-rc1 stable review patch.
> > > If anyone has any objections, please let me know.  
> > 
> > I don't know how much of this patch and the previous is classified as
> > "new feature" vs "bug fix". This patch requires patch 31 (of this
> > series)
> > as bug fix.
> > I'm not against it, just pointing out.
> > 
> 
> Hmm, the description looked more of a bug fix than a new feature.

Yes, the state clobber was an existing bug.  Patch 23 was a performance
improvement rather than a bugfix, though.

-Scott


