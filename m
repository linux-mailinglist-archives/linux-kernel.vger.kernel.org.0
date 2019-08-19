Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B975D9218F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfHSKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 06:42:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44261 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:42:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so1199708ote.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKz7X1bOX91IFiLRrxAIyxeYLCF31MeQ/lf4/7ZC31E=;
        b=PPNpVv5o15ZAwetfdHnEi+MItcpUI9kqu0yDmkF6M2mUojciHYOc+hJRYCxSZP4Fxn
         WlcBpPFmpjgxptGyVPCci7qzvmPWSTSJVO+owvDGXKJgHXEOjooRURssJl5IAMYf/WHJ
         cHj94Xj8zBvEmjj9mfUBusaaZ45MbFqy+ZIKuiBc4RiWznNl5Lq/QdfqrSu0GIEikaRW
         0eT3OPeClBeUwo4IkKzO0/QjlHK3sL+E+TuqP0og1uHHEkvXM8q9jU5uVLaUfzk4f0/L
         WttBIlzYwg3GE4ktLvmzzvGHhBz1h5cP/55sp2ODIB7VGwZ1aZHfvioGKJQ0n9VVujB2
         TNAw==
X-Gm-Message-State: APjAAAVK+78TPMQbTedtm9cC7+pAJV6+IECvxriFT4p/LbKdQ8RV5Kkx
        hb+eLpVe6k8cC3unRdHpA1bm1zCzIE5yzMQWm5A=
X-Google-Smtp-Source: APXvYqwlc3glSIqZLCpTOK8f6bALX7uNqhzqUYemvlVEzYDj6kIS+k9yqy3pC2BVvefSXMsMjI7ZhuYI4HguA01Pmw0=
X-Received: by 2002:a9d:12d1:: with SMTP id g75mr807314otg.189.1566211328197;
 Mon, 19 Aug 2019 03:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com> <CAHp75VfivaaAz1s5AD0BxcTCyO3P0yJUajKh0=WJ6f4w1XkHPg@mail.gmail.com>
In-Reply-To: <CAHp75VfivaaAz1s5AD0BxcTCyO3P0yJUajKh0=WJ6f4w1XkHPg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Aug 2019 12:41:57 +0200
Message-ID: <CAJZ5v0i7snXodEg0iO0yUaQgg=3o9gGKDed1Kd6V2Y4hgygWKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] software node: Introduce software_node_find_by_name()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 19, 2019 at 1:08 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > There was still one bug spotted by Andy in v2. The role switch node
> > was not removed in case of an error (patch 2/3). It is now fixed.
>
> It would be nice to have immutable branch for these changes. There is
> at least some other activity regard to intel_cht_int33fe driver.

When they land in my devprop branch, that will be immutable.
