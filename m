Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAA18BDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgCSRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:12:02 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55219 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCSRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:12:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1292149pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=R4q81Z5QMrL601yBvgvZ22H1vsVZ7jxrfvWspKctl9U=;
        b=HEgsRj/Umjt3bDRKeyBagbKVsAB5hqkobxm9VhitVyUU/tOxY/yi2I9xOVa5jDM4mP
         KQQmIGax4s9s0EA7W0QEw15/AQtqsSSJ0rBRbQj9xQhBOCLgI9mBfgT9owq+wcVo79pE
         EF8SuLXIFxhyevmOnwReXAKSICSdLSTi4pOKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=R4q81Z5QMrL601yBvgvZ22H1vsVZ7jxrfvWspKctl9U=;
        b=DgQgeZoGav22LVZaIDzsubWG0hQn24kil6HLpZyZbGCBL4iZdUBwM02IpYyp0BreRj
         Xz4YoIO9kCquqX4/aT1FXa8FXuWSdDiONit4M/yFqMmZjz2sIiYzrYSztNybIbQ1VYlB
         4O+2ONXidtWVPHnngaYijyGjW11Edjkm3WEXC0o1du8sR8Lroo9l+jo3f4txx40F2oMb
         CQ5WokpPJsmOZdeil1dWTajkgr5eVLzZ/W/XrBpYV60H72R4OxDusdSNYSQdWEKasZlV
         SFkjh0qMffLawSxwnVjGLgSmMpCHeFQ8Z9MfY/r/Sl5nQKdHzXrKbtu446SEcd9cVY9p
         66Jw==
X-Gm-Message-State: ANhLgQ1Gv2PtDeLle8NiIrBo/fcLEia+MJrXED8DKGy29Dh08WK4EH7/
        N1SFOoeHzWlkphy3/caRHStMvOJch5M=
X-Google-Smtp-Source: ADFU+vuyfRZyn7taxdoEfLj5z8q4S5lLtS97ZUBbW0A013dELnoxNGfgzDf6CXVedEadWpaeBu+AwQ==
X-Received: by 2002:a17:902:e905:: with SMTP id k5mr4192422pld.274.1584637921149;
        Thu, 19 Mar 2020 10:12:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x16sm2938956pfn.42.2020.03.19.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:12:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200319121418.5180-1-srinivas.kandagatla@linaro.org>
References: <20200319121418.5180-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] soc: qcom: socinfo: add missing soc_id sysfs entry
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org
Date:   Thu, 19 Mar 2020 10:11:59 -0700
Message-ID: <158463791978.152100.11401578350608469889@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivas Kandagatla (2020-03-19 05:14:18)
> Looks like SoC ID is not exported to sysfs for some reason.
> This patch adds it!
>=20
> This is mostly used by userspace libraries like Snapdragon
> Neural Processing Engine (SNPE) SDK for checking supported SoC info.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Maybe add a Fixes tag?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
