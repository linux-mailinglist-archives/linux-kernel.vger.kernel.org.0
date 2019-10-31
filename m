Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0729EAFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfJaMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:09:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33579 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:09:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so4460946lfc.0;
        Thu, 31 Oct 2019 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MM8p4D9tb2q7mG4877MY6R6xnh9uakrw6zADFmTTks4=;
        b=OPCqsC6VoU5JERR4Cw0CfReLN6eQqnM9iRJ8CH+KWnBn0jcB4gCsE49jFqANG9ZrFm
         Gg8B+QwvYfXHEPUHLleelZfQxiiZlTgjHgozQOBxZlgqNFXrUDA1VYpr3UvWhKkuSFs4
         wtslteQ3K0G+y8JgTmVNm7he27ntG62voXmO7Fl8z5l0d0zvRcvqcGciMjVeyBIrS5ZP
         MV+aGcCFg88yhnXL2BGiWjacFOQCb/BXgrf4X+CuYOWn1Av8//Y2CAINO1DwfuAIWZIl
         y8K8RyxzwZ+wdaEW6IlYMMy/pZ78EQteNAV5pEOfrq9YIovzMVoY2AgHeU1Tz4Ih6S5p
         tGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MM8p4D9tb2q7mG4877MY6R6xnh9uakrw6zADFmTTks4=;
        b=gfZIKXvEWTeMDk1yjY2ne2pp5rZhGga2gbB4Lus1fhDhz1LoWYsCDB4wrSfqCj3SDI
         lGdz6bF8FzNjxOeSEDOjX+BRw2vPs7812s08ZG9IqwWcyetaXMyrHvpRPfmvLN2cuZxo
         K41bJ+onQA+51PodNC+QrDriUfbU1bb3v2QvUM4UcCSskksXwSQfYD0RDPIf8T+OPi5I
         eV65+VKp5oioW+xBV2vNA4P2bk7SyXfdEseUHRAwF+uo+03+ST3fFO4co7DM7+C+9TI9
         I6knGWQHdqLU8RnlZRCYcTY6pTR2mzCtdvsGg2unDO8z8rEF3l5WMNw5b1aocEb8M887
         MdYg==
X-Gm-Message-State: APjAAAWqWhBXP7FuadLWyd+GhKGNZgjKtwMfqGU1hmEnRdtYTd4P3MqT
        IIMzrAtNnY+wtv5PVmCLrCWgSXLvgzxs+Fvb9E0=
X-Google-Smtp-Source: APXvYqwkYSRy9WIGL9SPdl9jeCJJ+BOIZ4Zza5PJfCxqy+TrdFNJETJc7MR5x1D+zSUZe3bjDByCvJLy8a/43ChjJu8=
X-Received: by 2002:a19:6759:: with SMTP id e25mr3136789lfj.80.1572523751272;
 Thu, 31 Oct 2019 05:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <1572515888-3385-1-git-send-email-peng.fan@nxp.com> <1572515888-3385-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572515888-3385-2-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 31 Oct 2019 09:09:20 -0300
Message-ID: <CAOMZO5C6kRvsGv_vR=r+5WesGDdLRUab4ri2P1V97-=juXcLQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: imx7s: ccm: add assigned-clocks
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Oct 31, 2019 at 7:01 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add assigned-clocks and assigned-clock-parents, then
> we could remove the clk_set_parent code in clk-imx7d.c.

Change itself looks good, but please do not mention the clock driver
in the commit log.

Devicetree should be OS agnostic.
