Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E143C28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 12:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgAULkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 06:40:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:31845 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAULkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579606824;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ybXLi6R8OFVJxwJTXa+4rhHQBHigWY9tbwDutRFSLs8=;
        b=tWAihGpU6Xed+vYYXrkcSB1MK6P6svDQkVJV+GB/1MaQBJYKy0hVmIT6Pqb3UYqkC9
        mZnrhunCP6NgQukj0U13qfLomDfpvybrvcHZifjcP4cmxa3e72nEk7YZuZ1m+1hOTdZK
        aH+/u+x8kjvNeN076uTMsfUlvujkvTQ4BmgWjPDSfvS3VcpqKpi5fpT6jUYPfyy4i1B9
        FoExQaY2/z4dbU3R9q7J22GZQDkuBMvGvzVlAgLslUfzhdMW9voZ8vD0WbME3crMb2q1
        6QC3dEl9hyLHB5zSHM0r+Wd38nSxPJYSRQfauwREcOMEgO7HAvRXbsWTT2+QSmW1WqyR
        8DUw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIPmLqeqmW5y9RyxgAGI3lPW17M7AHeX47YWyoc9gv"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.5 AUTH)
        with ESMTPSA id k05503w0LBeM6jY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 21 Jan 2020 12:40:22 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] lib/mpi: Introduce ec implementation to MPI library
Date:   Tue, 21 Jan 2020 12:40:21 +0100
Message-ID: <2593018.bJxuzB16oj@tauon.chronox.de>
In-Reply-To: <20200121095718.52404-3-tianjia.zhang@linux.alibaba.com>
References: <20200121095718.52404-1-tianjia.zhang@linux.alibaba.com> <20200121095718.52404-3-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. Januar 2020, 10:57:14 CET schrieb Tianjia Zhang:

Hi Tianjia,

> The implementation of EC is introduced from libgcrypt as the
> basic algorithm of elliptic curve, which can be more perfectly
> integrated with MPI implementation.
> Some other algorithms will be developed based on mpi ecc, such as SM2.

Why do we need a second implementation of ECC? Why can't we reuse the existing 
ECC implementation in crypto/ecc.c? Or are there limitations in the existing 
ECC implementation that cannot be fixed?

Thank you.

Ciao
Stephan


