Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F67DAB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439724AbfJQLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:36:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43783 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409177AbfJQLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:36:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so1489379qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8/Lz6l8sQ6PNj+KFicIECgEvYNy1usZIJng2CZIsbQg=;
        b=inLSz4cPMI+GJ9z0YEfQf9RIV4d9DhKHvhpv9tRsAhG8lBPHCahDt7L4dZdCUDpNT3
         V0qQsIIWtsi1zCvqA2zEvouImw2pz4PKQq7hNViCPYJJovM/WhPMwRFyY2ASg8xwBJ9e
         3W7+KJNGsqtkQD7da4idydHyGxNm4S89TLBE1EO5Nsrb7rxQFLv7OHaNsX/MyjrqvoQf
         sm4KR/GZnvc1LUVfYS7OZDzwz3t4PvX1fBGcOPD7sxVYWgEMvd2t+Q5JPWvhC3dGKSBs
         ZmiLjM0dWcfgsG936+m01CkzNYi/KsWTeJ9XauEjKWmMjpkupFQQrtOUJwu1GXjwYO4O
         E4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8/Lz6l8sQ6PNj+KFicIECgEvYNy1usZIJng2CZIsbQg=;
        b=NLtbaeBXrw7FUQeIrtRbZ+RtqBshBGUQtBK+ceywd/2gsGbaGBxZ6WEOXh7HzJdB0f
         2iwannljFntXfVO/RY0It98A4k2fCgsVoJZHy4goAnAtid0CYaRwE88MH3vxOv9x99UU
         nURloRp9cT/vyqtBhoZAkXlT+YBhw5nCVOJn4PpXyzUet8B+gehXRrR1KqQakRBW5Ndr
         dt0PECCNe00RL58dXFmVi9hWnvKLwO5SdOExDStiwnRsj7EiJcPqcSBikPIEsVozY67O
         htcrLUCG0xE6xgImVnTelq7ypAfYK7LUYSV6WtjixYdHG8c4N0erX53YLL4FKcbs6dru
         GCjw==
X-Gm-Message-State: APjAAAVrPWrJBxbnTPedqvZcorm71FdF2HL5Yp1ilUJLH2BllCazLXJp
        ssS0dynxWZb3x8tsSOW9MUO96g==
X-Google-Smtp-Source: APXvYqxdX0AeuN/dq2A2s87VdUR+xtxVcyeC34SKMarZg2FnGvyBY3fPdW9PrLgHFt8PN82r/JKQvw==
X-Received: by 2002:a37:68a:: with SMTP id 132mr2773971qkg.359.1571312212534;
        Thu, 17 Oct 2019 04:36:52 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c6sm1631979qtc.83.2019.10.17.04.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 04:36:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Date:   Thu, 17 Oct 2019 07:36:51 -0400
Message-Id: <577A2A6B-3012-4CDE-BE57-3E0D628572CB@lca.pw>
References: <20191016225859.j3jq6pt73mn56chn@cantor>
Cc:     jroedel@suse.de, don.brace@microsemi.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
In-Reply-To: <20191016225859.j3jq6pt73mn56chn@cantor>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2019, at 6:59 PM, Jerry Snitselaar <jsnitsel@redhat.com> wrote:=

>=20
> I guess the mode level 6 check is really for other potential callers
> increase_address_space, none exist at the moment, and the condition
> of the while loop in alloc_pte should fail if the mode level is 6.

Because there is no locking around iommu_map_page(), if there are several co=
ncurrent callers of it for the same domain, could it be that it silently cor=
rupt data due to invalid access?=
