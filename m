Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF21445A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 21:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAUUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 15:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUUKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:10:54 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A039F207FF;
        Tue, 21 Jan 2020 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579637453;
        bh=kvocdgJcl8ds3fXm6JZVZDMNPHGRqlhuKAmVopKG0zk=;
        h=Subject:From:To:Date:From;
        b=TKxlbnX8+QtDmS3D0gZt/uezz3meJpsnUXZg5jJ4mr3IhRz1HrP5SW46pkzFinRww
         LR8r8KkLmBv3LtlzfTtVi4XZVaS3DdyFj1VF2nsM8y5MTiLmrp3+D35CbHRlyCjOUn
         8iZM0UHm08V0X0Xu/Zpnus/gpY9Z5SK1qtfVFLnY=
Message-ID: <1579637450.19595.9.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.164-rt73
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 21 Jan 2020 14:10:50 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.164-rt73 stable release.

This release is just an update to the new stable 4.14.164
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: aa78b8aa811088d338796a14f3f618878635759f

Or to build 4.14.164-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.164.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.164-rt73.patch.xz

Enjoy!

   Tom
