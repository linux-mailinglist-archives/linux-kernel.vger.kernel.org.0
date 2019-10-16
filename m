Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92FD940C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404944AbfJPOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:38:06 -0400
Received: from gentwo.org ([3.19.106.255]:48200 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404542AbfJPOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:38:06 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 80DB83F1C2; Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 800B53E939;
        Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
Date:   Wed, 16 Oct 2019 14:38:05 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 25/34] mm: Use CONFIG_PREEMPTION
In-Reply-To: <20191015191821.11479-26-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1910161437310.12925@www.lameter.com>
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-26-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Chistoph Lameter <cl@linux.com>
