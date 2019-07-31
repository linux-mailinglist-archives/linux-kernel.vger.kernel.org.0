Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA30B7C08F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGaL4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 07:56:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfGaL4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:56:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zBjP5xMjz9s00;
        Wed, 31 Jul 2019 21:56:41 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Carl Love <cel@us.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Paul Clarke <pc@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 107/107] perf vendor events power9: Added missing event descriptions
In-Reply-To: <20190730025610.22603-108-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org> <20190730025610.22603-108-acme@kernel.org>
Date:   Wed, 31 Jul 2019 21:56:40 +1000
Message-ID: <87a7cuqux3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> From: Michael Petlan <mpetlan@redhat.com>
>
> Documentation source:
>
> https://wiki.raptorcs.com/w/images/6/6b/POWER9_PMU_UG_v12_28NOV2018_pub.pdf
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Carl Love <cel@us.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Paul Clarke <pc@us.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: linuxppc-dev@ozlabs.org
> LPU-Reference: 20190719100837.7503-1-mpetlan@redhat.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
