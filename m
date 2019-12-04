Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26663112D13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 14:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfLDN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 08:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfLDN6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:58:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2231B2073C;
        Wed,  4 Dec 2019 13:58:46 +0000 (UTC)
Date:   Wed, 4 Dec 2019 08:58:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.2.21-rt14
Message-ID: <20191204085843.5cfcfd25@gandalf.local.home>
In-Reply-To: <902943c5-9fee-ef45-2b5d-8baa6fa00685@manjaro.org>
References: <20191204095144.kvpbinxqptdszvqq@linutronix.de>
        <902943c5-9fee-ef45-2b5d-8baa6fa00685@manjaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 12:37:34 +0100
Bernhard Landauer <bernhard@manjaro.org> wrote:

> Sorry if maybe I have missed any announcements here, but my I ask if you
> are planning on releasing patches for kernels >5,2 in the near future?
> Or is this project being faded out altogether?

Hopefully in the near future this project will be part of mainline.

-- Steve
