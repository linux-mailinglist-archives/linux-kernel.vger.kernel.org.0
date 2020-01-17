Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61CF1405C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 10:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgAQJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 04:01:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:01:45 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1isNVf-0003eT-Nj; Fri, 17 Jan 2020 10:01:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] smp: Avoid memory allocation in on_each_cpu_cond()
Date:   Fri, 17 Jan 2020 10:01:34 +0100
Message-Id: <20200117090137.1205765-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 is using on_each_cpu_cond_mask() in native_flush_tlb_others() in a
preempt disabled section. The memory allocation in
on_each_cpu_cond_mask() gives me a headache on RT.
This is an attempt to get rid of the memory allocation and potentially
accelerating the code path :)

Sebastian


