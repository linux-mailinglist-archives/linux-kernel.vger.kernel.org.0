Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0550144DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAVIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 03:38:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:38:13 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iuBWb-0004Rf-HC; Wed, 22 Jan 2020 09:38:09 +0100
Date:   Wed, 22 Jan 2020 09:38:09 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20200122083809.ipky22egqn25sqgc@linutronix.de>
References: <20200117174111.282847363@goodmis.org>
 <20200117174131.158849136@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117174131.158849136@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-17 12:41:36 [-0500], Steven Rostedt wrote:
> 4.19.94-rt39-rc1 stable review patch.
> If anyone has any objections, please let me know.

We (and by we I mean Boris) tried to reproduce it on the actual HW and
failed. So I assumed that the bug is no longer present in the devel tree
which was tested (and most likely fixed in the meantime). I can't say
the same with confidence for the v4.19 tree.
I think it would be best if that one would not be backported.

Sebastian
