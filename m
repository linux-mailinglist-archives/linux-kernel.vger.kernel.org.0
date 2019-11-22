Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FF106112
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 06:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfKVFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 00:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfKVFxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:53:46 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA10C20672;
        Fri, 22 Nov 2019 05:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402026;
        bh=ZFLASfdovryR7LiQczr3/sQr5TcaQLVbPu/4tYd/oKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QquYUjLfoTKdsrZ7MGtb3zHo/ZcZ4eCgYnavZ2KTeAXwgXTlanJiQeZGwbOa/WSsk
         eu/fGao9IahHDtq0K3z+JCGsgxxJ9UQrrsT9x6oTE3671lv6kdNaYHGs+WGyHiawdv
         i1/Xo+JaZO4wL7Yqf8jtDKF3LcQbDBL07Y/4QpWI=
Received: by mail-lf1-f49.google.com with SMTP id f16so4565818lfm.3;
        Thu, 21 Nov 2019 21:53:45 -0800 (PST)
X-Gm-Message-State: APjAAAWSq1ftPLIjXsXF254B0iV6JsiIEi0lu1VOfZwznTNNVLNCaNgt
        4cHkeQojyh5CMCPxzHWoandg0wNuc7UqO4IWHCE=
X-Google-Smtp-Source: APXvYqxWlWvyv7M1PttJXoThDFMC3mJKD4wDrzEDT/AI63x858kL8RmqFmef/OrVPWtH2YgBq5PxUJwQ50uKJsXNy+s=
X-Received: by 2002:ac2:51b5:: with SMTP id f21mr10474788lfk.159.1574402023874;
 Thu, 21 Nov 2019 21:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20191120134153.15418-1-krzk@kernel.org> <e93c7c7e-dac7-8c8d-c68a-edaa9106d6ac@roeck-us.net>
In-Reply-To: <e93c7c7e-dac7-8c8d-c68a-edaa9106d6ac@roeck-us.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Nov 2019 13:53:32 +0800
X-Gmail-Original-Message-ID: <CAJKOXPfw0nEFJum_uVqSBzNX2b_gVFbSuoz6gnULhyCENHORqw@mail.gmail.com>
Message-ID: <CAJKOXPfw0nEFJum_uVqSBzNX2b_gVFbSuoz6gnULhyCENHORqw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: Fix Kconfig indentation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 13:52, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/20/19 5:41 AM, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Quite frankly I'd rather not have to deal with such cosmetic changes.

I understand, let's skip it then.

Best regards,
Krzysztof
