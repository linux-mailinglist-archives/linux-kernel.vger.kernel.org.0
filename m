Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96610D059
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 02:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfK2BWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 20:22:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41834 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfK2BWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:22:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id m125so24176444qkd.8;
        Thu, 28 Nov 2019 17:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i702aI34Ezre+0jrw+L6vx9jKRLYCS8yu6Eoq+4nGJE=;
        b=dTehSbOkY05Dr9nkgHtoKE1xSiDuW5wG/Ajt1b3KazxlRGS9m76EmQ0EGoKnsfLbPb
         Duue+a7zkw1MO0Gzq2mA7tdyiQd1nS3VT3d3UkK3yXBnNGvLy/ZTkLPilzlW40pp3+me
         NlZ4IVSvcbXLRiRtthWxx0lEasUQXG07FUQkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i702aI34Ezre+0jrw+L6vx9jKRLYCS8yu6Eoq+4nGJE=;
        b=LxhWmQQKeLDEsxGvvkS72xTVcDAf4JK6apNvFXxxfDJSUnbnMNpsmVV83v0i91PNQf
         f+J2EuPFnyYKcEF/ymfACdVvA7dDv/3+EJAvNlVcZW7p3CKdDoBVur8wI4YCVtWGaQoC
         FP0iHIQ8BavQBzHSNTr7lG/d8KAaUc8ocnzFD6DsxPG0b+IgdD+3G5zX2LBIZnqEGuhG
         tviJppgcZ/G6pytcCOZN2o0Xvisl9JuWPgrWiInN/y2dm5XkvhY1NvzehDFlt/6m89KN
         iSA14fK9s3+DeD6StVkAgy729IOTX7CfUzj8rsQMtx3oigmc4dJL05GdsBqgiWF2A73E
         Nj3A==
X-Gm-Message-State: APjAAAVq47CSbEiA7DkJSruc6vfNTtOugTAH2eiLQ875h5A7v+uiSOLw
        nrnvHYb9LxRDIzYs54cfU4AE6DvouvYQGO1BOSs=
X-Google-Smtp-Source: APXvYqzz9CXdrxz6xF/zS1AxHhxumwbTlTDCuJZgIlcJE1zBHaC5e91x03jmrOXsqeNZRVN0YWwsyRZ5BX10t1m375k=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr13463552qki.330.1574990574036;
 Thu, 28 Nov 2019 17:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-3-andrew@aj.id.au>
 <20191126180320.1A2132071A@mail.kernel.org>
In-Reply-To: <20191126180320.1A2132071A@mail.kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 29 Nov 2019 01:22:41 +0000
Message-ID: <CACPK8Xd73GokmT=6ABDQSJoumHL4aMLx3R2qkp9PqGThRExz8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 at 18:03, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Andrew Jeffery (2019-10-09 19:06:55)
> > RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> > single gate for each MAC.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
>
> Applied to clk-next
>

Thanks!
