Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8ACB10DFA0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK3Waj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 17:30:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36225 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3Wai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:30:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id f16so25156087lfm.3;
        Sat, 30 Nov 2019 14:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4tOixWpgcrdjui38T5oTL+44XGlT7eV3jeFaOo0/CU=;
        b=JUpwMiLS5buD2r0U3njb3GQpt0fCXwP17Q0ZUa6Jo+q2lhsRmjFmbjWLbTtas2sF59
         4BQA//Z9gPOq86l6QfB+uiuQI5tjuprAreaQetVwcpYuKgEQkdDVaP9ACd27aWjojJOh
         z7bhwBsX9TQz/Vy9CfFVKh53pw4eA+x3Frzj08Sk40CHRwuvzZhhRDjEu8NsuESJqiKm
         goKc3Sl/dzGfxpZSZrhC0uFJzOsYlaO/auX8MzdyS22mbUmgAgQTzM28OK4q/iOCqI2v
         KSz9ZOqCe4xKnziGCMnS0V0HF1SwTTwIGs1kNFVezgjkjCGR+p2eeDifBu9FwI1cE49F
         JKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4tOixWpgcrdjui38T5oTL+44XGlT7eV3jeFaOo0/CU=;
        b=NldSVJawY/m5LxKJdDxHNR3I0jmLXjvWVqT2aJZJEyFk5NM3iESBa1/TRakxIUp2Pm
         gMnFEtmokXX+u4UhUY8eG29u3h9nDeZ7B602gc5lFNK+wAcNml98WjjOpiB9VBsYjcAx
         ka+XUc7pHDZGjDmz0LfDRCQaZ2rb3GUCe3Bj56U/tD2k1MBC6V5laZNnJtzBb8B1pQhH
         9KzEy2Y8dd4m2xc6CDRcHcUrDr/4Z2UUmb9pLMXnBkgb2uDDR9gOaDS5sVKm+8mkcNV9
         fQMufhLxFUJLFDEnbYD+UALnh9Ttx75ZQkfZLhL8Hq8TL+9BJjSxg1plFDcTQF3PR8AO
         F0Zg==
X-Gm-Message-State: APjAAAUa89pKjNF5I826a/MUymm/aLqwOn+GOIXQSDNESXsVjzbzaBC7
        E/0m2OiP7GiN87jEzf/haWzwvG3YzSPYsE/Q9ro=
X-Google-Smtp-Source: APXvYqyuHeD4Xafj7MsA4yP65IUXVSAqx+KBRYqbOdUBNOl/5bFe92S3swaJTTlNZZO4J0bx19bSxo9sjure05JDEGc=
X-Received: by 2002:ac2:50da:: with SMTP id h26mr4784575lfm.80.1575153036513;
 Sat, 30 Nov 2019 14:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <20191129234108.12732-2-aford173@gmail.com>
 <CAOMZO5AyLBrsxr5rqkWgf44X0CQdqHcdaCLRaWLC25b18bF+xw@mail.gmail.com>
In-Reply-To: <CAOMZO5AyLBrsxr5rqkWgf44X0CQdqHcdaCLRaWLC25b18bF+xw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 30 Nov 2019 19:30:51 -0300
Message-ID: <CAOMZO5ALQQxoWFC9J5ZwT6DtsuVg-FaWCcGbcPK=psokWWRF8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add GPC Support
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 7:25 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Fri, Nov 29, 2019 at 8:41 PM Adam Ford <aford173@gmail.com> wrote:
>
> > +
> > +                       gpc: gpc@303a0000 {
> > +                               compatible = "fsl,imx8mm-gpc";
>
> You could do like this instead:
>
> compatible = "fsl,imx8mm-gpc", "fsl,imx8mq-gpc";
>
> and then you don't need patch 1/2.
>
> Also, "fsl,imx8mm-gpc" needs to be documented.

One more thing: when you add a v2, please specify the SoC name in the
subject line:

arm64: dts: imx8mm: Add GPC Support
