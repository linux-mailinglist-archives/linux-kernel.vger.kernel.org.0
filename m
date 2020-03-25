Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5085E193245
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 22:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYVCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 17:02:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37638 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgCYVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585170173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1kdP9ngOxBVZus1W4Ab/5pM031b8xQowWgA+AhTWqQY=;
        b=SnMuqMmylORaIiwtv/xO84Qs2ZkJSBHKzlyR5+xBnvrGpmvfo4FuStPYNxw3rx5+Vjm6V3
        WJWanozZF9WZrL/ILcOh8xL+Tf6n//Fd2wyS+YEavX6nAFKnifmSxZgMrLTR9I2EgnuBPk
        duaEd83P3pkn0mgIRzzWg7+tykWD6kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-r1YnDeZJPJudzkd1-U_h5g-1; Wed, 25 Mar 2020 17:02:49 -0400
X-MC-Unique: r1YnDeZJPJudzkd1-U_h5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F3C18CA240;
        Wed, 25 Mar 2020 21:02:47 +0000 (UTC)
Received: from tagon (ovpn-116-65.rdu2.redhat.com [10.10.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7EBA5C1B0;
        Wed, 25 Mar 2020 21:02:44 +0000 (UTC)
Date:   Wed, 25 Mar 2020 16:02:42 -0500
From:   Clark Williams <williams@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.217-rt140
Message-ID: <20200325160242.6f6ce068@tagon>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-land!

I'm pleased to announce the 4.9.217-rt140 stable release.

Note that this is a stable maintenance release, so no changes to the
actual RT code, just merged in the v4.9.217 stable update.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 17124a9c60e7d12becb893f35d51d9a5054a13e8

Or to build 4.9.217-rt140 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.217.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.217-rt140.patch.xz


You can also build from 4.9.216-rt139 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.216-rt139-rt140.patch.xz

Enjoy!
Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

