Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162501453DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 12:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVLeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 06:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:34:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED2624684;
        Wed, 22 Jan 2020 11:34:05 +0000 (UTC)
Date:   Wed, 22 Jan 2020 06:34:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH RT 25/32] Revert "cpufreq: drop K8s driver from beeing
 selected"
Message-ID: <20200122063404.41760c35@gandalf.local.home>
In-Reply-To: <20200122083809.ipky22egqn25sqgc@linutronix.de>
References: <20200117174111.282847363@goodmis.org>
        <20200117174131.158849136@goodmis.org>
        <20200122083809.ipky22egqn25sqgc@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 09:38:09 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-01-17 12:41:36 [-0500], Steven Rostedt wrote:
> > 4.19.94-rt39-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> We (and by we I mean Boris) tried to reproduce it on the actual HW and
> failed. So I assumed that the bug is no longer present in the devel tree
> which was tested (and most likely fixed in the meantime). I can't say
> the same with confidence for the v4.19 tree.
> I think it would be best if that one would not be backported.

OK, I will drop this one.

Thanks for looking at these!

-- Steve
