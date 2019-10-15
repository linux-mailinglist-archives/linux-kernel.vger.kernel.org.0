Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB2D7FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfJOTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:18:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJOTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:33 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL1-00067i-Sb; Tue, 15 Oct 2019 21:18:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
Subject: [PATCH 00/34] Treewide: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:47 +0200
Message-Id: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces 'PREEMPT' with 'PREEMPTION' if the functionality
behind it is not limited to the preemption model CONFIG_PREEMPT but also
required by the preemption model CONFIG_PREEMPT_RT.

Sebastian

