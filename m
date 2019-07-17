Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C46BFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfGQQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 12:50:16 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45064 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfGQQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:15 -0400
Received: by mail-lf1-f53.google.com with SMTP id u10so16999931lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNAXEfmmabkDqnE/Fk/8mS9Vl1MA/WibJg8QIkwtN7A=;
        b=V38Ojkmxy8ffF/ZvBefbuc8hq37BA7KyDFHi0jL11iWRUAAMPX8Ghao9zSC/X7qsb/
         DGCrw1iMx9WTCA1TfZUhUqwPe6NQSwUbESwrtsfUigLoP33R5aQCKgyVB8dKsJ4+xq9s
         +oL7Fg7w17YPfRIzjkSBRhMy7JD1qATIr4L4mhWOSkY5ODU2QU5TocCN8GbWJtf8ZtIl
         yxYqVcuKdtiFZmmTT0SyjucLEdhT0yTdVyCujqSLSd9GTRStNu8KQgrobjC5YokCZJBj
         TUw9uo2RN+kgzoyGYaOHo1XKWp6lo+xdf8SCstUpI673KkP9SPp+r0dRrlmYESjAW4Ud
         1ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNAXEfmmabkDqnE/Fk/8mS9Vl1MA/WibJg8QIkwtN7A=;
        b=n0BFLJkApzeLmLQhFh4YNhmwQpPQSenF4gqJO78n4gK8CqyGQZ3A6eU4P7smUQ0soY
         er1LggwOQUVOItjNDAkefOBcL+yRe4gJlFEbxOMQ6U+vMcAWrDaO0ft1wV4iGP9Kz4bL
         WbpM3iOMcuJK1Q7YMzXpF1dopvoqOGoRMxX7oXNm5xjpA/IvUqsr/+Uu9GqP7X5IVaeU
         zyAK5GJ2634LQd15mql9CdWkXEfz8WofSvNGdvI1zTkDuY9L2Nwg5OmpNnhSQqcGmD+k
         CDhOBnj/dGFUsluXFg0qrYxQqkCZPmcYIaaZRcdwqQvE0QyQ+bKaXmIRZy5N9+84jnFe
         io0Q==
X-Gm-Message-State: APjAAAUXUSBYpNE7YC1efCqU/8g/WbsXG7U6+OCf98TuGpD7lyD8ktKe
        e3Kfbw3MjBOxS6pa+KmaR/p2oc6zpnQiqV1kIoc=
X-Google-Smtp-Source: APXvYqwehLVFid82yMKj2mL9bSbFAxO2VNayn/RZivwipwvShdidziMWPYRoLWtd4JixmgXj/1mgQyy5AS+oHjq+vDQ=
X-Received: by 2002:a19:cbd3:: with SMTP id b202mr18741578lfg.185.1563382213570;
 Wed, 17 Jul 2019 09:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-7-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190717163014.429-7-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Jul 2019 13:50:02 -0300
Message-ID: <CAOMZO5Bqf-mWxsvgVYg1+xk=hvGRNocfhRH1F39HBD7q_UY2uw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ASoC: sgtl5000: Fix charge pump source assignment
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> If VDDA != VDDIO and any of them is greater than 3.1V, charge pump
> source can be assigned automatically [1].
>
> [1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
