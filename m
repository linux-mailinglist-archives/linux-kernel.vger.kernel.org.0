Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7E10DC08
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 02:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK3Bik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 20:38:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbfK3Bij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575077918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTnXbZFBBDmZUTH1cnw+0MqUeA0BptKMDT2UAmqfI5c=;
        b=Tnw3e+MOinPU/XsdXlF1ybs6Bj/SmEWp59WcphZy5JT196zURuwgJF2kIhbCfhCMZWGA7M
        aFGjS2dt/bXe4tMcKIuna2qjTJD5yaaE9SO3iMLPMAMaLb/VXpb1wVfQbaDJ8p3nK7F6bg
        52Hxjn2597BUgv7Q6Tt2gX6fz5ZRqwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-NZmw11r7ORmBOIciamsQcg-1; Fri, 29 Nov 2019 20:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF9B580183C;
        Sat, 30 Nov 2019 01:38:33 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-32.rdu2.redhat.com [10.10.121.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A128960BF1;
        Sat, 30 Nov 2019 01:38:26 +0000 (UTC)
Date:   Fri, 29 Nov 2019 20:38:24 -0500
From:   Neil Horman <nhorman@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v24 01/24] x86/sgx: Update MAINTAINERS
Message-ID: <20191130013824.GA28617@hmswarspite.think-freely.org>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
 <20191129231326.18076-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191129231326.18076-2-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NZmw11r7ORmBOIciamsQcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 01:13:03AM +0200, Jarkko Sakkinen wrote:
> Add the maintainer information for the SGX subsystem.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0154674cbad3..08a67272ed14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8512,6 +8512,17 @@ F:=09Documentation/x86/intel_txt.rst
>  F:=09include/linux/tboot.h
>  F:=09arch/x86/kernel/tboot.c
> =20
> +INTEL SGX
> +M:=09Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:=09Sean Christopherson <sean.j.christopherson@intel.com>
> +L:=09linux-sgx@vger.kernel.org
> +S:=09Maintained
> +Q:=09https://patchwork.kernel.org/project/intel-sgx/list/
> +T:=09git https://github.com/jsakkine-intel/linux-sgx.git
> +F:=09arch/x86/include/uapi/asm/sgx.h
> +F:=09arch/x86/kernel/cpu/sgx/*
> +K:=09\bSGX_
> +
>  INTERCONNECT API
>  M:=09Georgi Djakov <georgi.djakov@linaro.org>
>  L:=09linux-pm@vger.kernel.org
> --=20
> 2.20.1
>=20
Wheres patch 12/24?
Neil

