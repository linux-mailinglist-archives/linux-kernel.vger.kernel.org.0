Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4304512E401
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgABIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 03:47:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgABIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:47:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so38531930wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J3vpyuDp2fSfI1qhxZyNCpDspi8gOZ6c6sySzOGZgtI=;
        b=ETMcyAjibH5n172XygOMVaHuPRax3MGgc0BbFkqXLH7/36LaaNc+EKQY40lSeUgVnw
         6DuzTkMGXI7AbpR3gcRRGCyQqMjctZG9PfzGuk61Z/vgxcx0hscCfUbkpF6rMqH7Navk
         jAVbh1eLBI73S2OfF+vlXQp9PdynXWk+FuRgIfYaVVQ5368gwxaFwa7Q0yf6be0xmAGH
         PGQtdhh/jBmqLbKtV7B3CKbvvPo6D0NlNbSAfN0UT89zLBGbkD5tkFIqiU1OVytEkBpq
         ThjtAIVCMfTLXIZWymFgmebd2zdU/3g83MrZexOvp5Y/mrYGMmtVK0yBKC3H8O6Cgi13
         njxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J3vpyuDp2fSfI1qhxZyNCpDspi8gOZ6c6sySzOGZgtI=;
        b=mbTUELXVoI+rTDucHvVgTu2cjvZq5AiXGJoWzRLZKbWhy+s2WNy8N34nwVeGHs3NR4
         TFxpN53dTMGuk35nXoiVtS40AMREizpVqSrScbqNT7F2XS5VjQkyxV7Iphg+US0xkRNQ
         feOVNS+L1sJYY2DdDcOmub8wouLJi6zjK02hAoQXHvFC4GtSPwhEmViDMEQ0ikETCUsV
         RqkAWoUng81zZHaJIPLKIc6WrLeYfgxlXwOQ7y96O0sOdXwrHgVuMCTUC+15OF/eWb06
         sk9FHzHnk3rKsUqz75k6oM7OPgvmT7VyOFfR52Las0Zb96Dbz0DJN5sbPZixzp+K/Ie4
         Uf/g==
X-Gm-Message-State: APjAAAUe5gXQwGyMAuCjvA0GGnugogmgj4DUOBshBYycS6fzkqMjTAlQ
        TzhLz7mbxiwULbeqJkJtdz/zsQ==
X-Google-Smtp-Source: APXvYqylKev69ahCZ35+EK+4UPvdRjneJYVaHT074cYq27+Fas8yAzV9sioz80p55eadrTDO/VC0Sg==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr81603053wrl.117.1577954867937;
        Thu, 02 Jan 2020 00:47:47 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id a16sm54987960wrt.37.2020.01.02.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 00:47:47 -0800 (PST)
Date:   Thu, 2 Jan 2020 08:47:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20200102084759.GB22390@dell>
References: <20191217084824.GA26539@localhost.localdomain>
 <20191226221654.GA30474@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226221654.GA30474@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019, Rob Herring wrote:

> On Tue, Dec 17, 2019 at 10:48:24AM +0200, Matti Vaittinen wrote:
> > Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> > the binding document to two separate documents (own for BD71837 and BD71847)
> > as they have different amount of regulators. This way we can better enforce
> > the node name check for regulators. ROHM is also providing BD71850 - which
> > is almost identical to BD71847 - main difference is some initial regulator
> > states. The BD71850 can be driven by same driver and it has same buck/LDO
> > setup as BD71847 - add it to BD71847 binding document and introduce
> > compatible for it.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > 
> > Oh dear how bad I am with yaml...
> 
> Looks pretty good overall.
> 
> I hope 'yamlify' doesn't catch on. :)

Adopted.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
