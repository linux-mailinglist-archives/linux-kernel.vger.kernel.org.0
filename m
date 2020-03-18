Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC3189A53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCRLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 07:14:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCRLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:14:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id y24so479824qtv.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sgyNbxuqyjr0qsNo2fb06dE8sRE+6o19+81LTsUoSA0=;
        b=gFYEGhVsLWDPfb3FaC35adoF5ttqjS3XQlnxbKwP7zr2CA3rvPiHtWlUnOee9N5KDD
         R8EK3pw05OTxaGnz+whhkBEY687jvqKt/vOWv1rQK5EXc50dVaLSBvG23hSUdDn5QUn3
         C2hwmfJhGQEo0CAtdC/S60wNPmxer7D/lhj1rWt9k5mQNGy6c/gwcNcIqc3v8dYyJR16
         Pl/ZZpdrszp1DxAfkTBVqcMKOb/p+6jrVMHeSr1Hq51THjKThrMUYukNj0EuHDDBus4p
         AGeF8iSaDnZnaboV3ok/lfVlHTDxWbnl9z+BggsU5ljj5C3Fx/uXMohmr0zIYx94AnJ8
         hSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sgyNbxuqyjr0qsNo2fb06dE8sRE+6o19+81LTsUoSA0=;
        b=bBU6moppN1xTdIReSnJK2YrTD+3B2azM0tavjLsUv4fwm6UE1VaU9974RDtWBh93/h
         8e5brELrDDQiFuVwDCq6r8E+GhZm7F62ohPV0ZTZa56FPQoDIzdb23LGYUL966WbmYDp
         +Bjs9uiwQkC3EcGQDc8nvhcm7IVa2i58+pMKXr8mH9l7QOy50NdExxXoyOVQFvJBEuwn
         K5nTFEo6MfKlffzb7PVfkA6Xo2rnJs+NhBOzGUv62nnsFKZqMRWMC87584Taknw9v6BZ
         nwdVPOubFFBKAruy6oFTprrW1K/OaJ5Nbhr8eRGpvZxELMKJC/bv9EwAp68jE3d7KWXJ
         yL5Q==
X-Gm-Message-State: ANhLgQ0sWHdXdbwknF2jn1PY2zp+g72COr1Cirdd8crcGF06Hklf74Hl
        gz8hgnBm6MxGXDtJeSiASDwilw==
X-Google-Smtp-Source: ADFU+vungW6oo2qwG68CHP49iz0ohwYX3aEM++C6PAJnfZNPYYQOtB0SXA4Gw6VHTcAL2kirl1VGAQ==
X-Received: by 2002:ac8:3141:: with SMTP id h1mr3836627qtb.108.1584530066205;
        Wed, 18 Mar 2020 04:14:26 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g6sm4145161qtd.85.2020.03.18.04.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 04:14:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
Date:   Wed, 18 Mar 2020 07:14:24 -0400
Message-Id: <3F34A59D-2EB6-48A9-B758-2CB8B2EA1128@lca.pw>
References: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
Cc:     jroedel@suse.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2020, at 1:27 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> How about changing the commit subject to
> "iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()"?

Just a bit long which should be non-issue.
