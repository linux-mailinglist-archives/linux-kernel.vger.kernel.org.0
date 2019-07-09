Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0328638E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGIPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 11:52:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:46424 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfGIPwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:52:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C77A22A2A84;
        Tue,  9 Jul 2019 11:52:18 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id xsjFskoTtcOq; Tue,  9 Jul 2019 11:52:18 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6038F2A2A7C;
        Tue,  9 Jul 2019 11:52:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6038F2A2A7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562687538;
        bh=5klOSNIno6HXWTvWyvWMe1zJvNm5l++YeHh3NU3ODNk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vFN6luL8ZYCv0+2xVs2nAT1DWtUdEq7l926QxOAz2PO67k0M9XBZth4d+6A45rE9+
         MUE86ArQNcnZWuWfspUlH6xP8tmqN7OSipSK6tuX2Xa1fYyX1yOslzumJDJCBauezM
         iGTsYx256tpJ1aTZUQTbkC4yW5J9AlQTAkxyjCzZfzTbpyfd/V3Lyd0BZDyimcuHgc
         JntT4O5JhUd2PKopEd8mQUmVt/77xjnvM+vxjJkVOpscLCeR+SJinGD8HBrPdaqOfk
         9pScWOoUFSTcP2PPW9BSA6qcPdjKcbdcNJg78Sk0fJYYGcs3VjwgAfDNLUNNN3jBEV
         5lOF8u0s4ZBig==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YI3xn3pFAFu6; Tue,  9 Jul 2019 11:52:18 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4A50B2A2A76;
        Tue,  9 Jul 2019 11:52:18 -0400 (EDT)
Date:   Tue, 9 Jul 2019 11:52:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <262027381.15855.1562687538131.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
References: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907081531560.4709@nanos.tec.linutronix.de> <20190708140732.GI26519@linux.ibm.com> <alpine.DEB.2.21.1907081618270.4709@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
Subject: Re: [PATCH V3] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: +8Uf++qq2pM+ULxRrVoYbRDAlrUa1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 9, 2019, at 10:23 AM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> +void set_cpu_online(unsigned int cpu, bool online)
> +{
> +	/*
> +	 * atomic_inc/dec() is required to handle the horrid abuse of this
> +	 * function by the reboot and kexec code which invokes it from

invokes -> invoke

> +	 * IPI/NMI broadcasts when shutting down CPUs. Inocation from

Inocation -> Invocation

The rest looks good!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> +	 * regular CPU hotplug is properly serialized.
> +	 *
> +	 * Note, that the fact that __num_online_cpus is of type atomic_t
> +	 * does not protect readers which are not serialized against
> +	 * concurrent hotplug operations.
> +	 */
> +	if (online) {
> +		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
> +			atomic_inc(&__num_online_cpus);
> +	} else {
> +		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
> +			atomic_dec(&__num_online_cpus);
> +	}
> +}
> +
> /*
>  * Activate the first processor.
>   */

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
