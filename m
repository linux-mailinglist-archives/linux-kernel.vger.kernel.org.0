Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A232B15636D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgBHIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 03:36:10 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:29495 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgBHIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 03:36:10 -0500
X-Originating-IP: 66.190.246.67
Received: from localhost (66-190-246-67.dhcp.astr.or.charter.com [66.190.246.67])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 63560240003;
        Sat,  8 Feb 2020 08:36:06 +0000 (UTC)
Date:   Sat, 8 Feb 2020 00:36:04 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Applying pipe fix this merge window?
Message-ID: <20200208083604.GA86051@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hammering on your pipe fix patch (switching to exclusive wait
queues) for a month or so, on several different systems, and I've run
into no issues with it. The patch *substantially* improves parallel
build times on large (~100 CPU) systems, both with parallel make and
with other things that use make's pipe-based jobserver.

All current distributions (including stable and long-term stable
distributions) have versions of GNU make that no longer have the
jobserver bug.

Based on that, would you consider merging the pipe fix patch in the
current merge window, giving people plenty of time to hammer on it
further?

- Josh Triplett
