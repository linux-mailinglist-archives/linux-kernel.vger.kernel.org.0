Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25A9C772
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 04:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfHZCx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 22:53:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34598 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfHZCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:53:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so12997145qkk.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 19:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W0DKLeXeBCn4HSQPBp6hYRBMjTdyNzAMlLaQA2xi4SA=;
        b=vjJ4cLvHSd6uZNBnkzacvp6uTJWXzAIkcQSFMfixwPzHWA2oT/B9v8KAPd2Jd/gzPy
         ghUpyCipu2pbtCVi+WoveDJE5pgMZCJdp3hWzATXyNDSbZGav+JlUPhpJiwHUB5ExR2Y
         8Fvh3HBFj7vJq5cjao6B8rEe0P3vvOf901GIE0E2ONT1RqWQY9snFTjaNZte/N8JolyX
         ihdzyZankYOPPnLYIGpMTS27Lb5dsoAePtzmWVhgn1fRW+F48hsrkfzZmGXkdqRqgNTE
         fEg5QXHVvT0Zhd71xgEW+05v32z73h6Eoc2DpUTUb8yKQqhGPHENByE2ORUcfNl9WOcC
         AxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W0DKLeXeBCn4HSQPBp6hYRBMjTdyNzAMlLaQA2xi4SA=;
        b=mtDv8jcDt4RKzsVynRkfPgbDXPSukmSjOVSQm6EFlTEdMmzO1twfZjo57cM9Y2l90i
         jYct6gGbTVojt8Xl6zEd2lYZkHvynXw6/bsjZzTFvgm3Hiqq9tkf2rsmYIETekoeLfwh
         IOryIy5zkdOoUAIn+vbQOC6arXPhL/geiHRzSiBwkGRYh38UZNbCkW4xoThyYjTBLCYw
         N/hfwcSCtutBejqdKeLnw/s4wqsHqfo7gCDS/RoQZ4qizbbIcmhkrlZj5Pbh035mtdSe
         29ETKT3f9iAINTMKY2vQm0GUSG2C4P73hVd4saYKmxkSQH9t2lt4na9nRJgAhatAg3BD
         iUZw==
X-Gm-Message-State: APjAAAX/QR+lDwG0PUgk4fUNHOnz4hzbqwxpiMyaHw0n2vvS+iBuyjX9
        C5z90piBPA2wdNrb3XuTUcaDwt0jc/4Z7zlIrmX9Jg==
X-Google-Smtp-Source: APXvYqxuSYbqeouE7l1IOuwsKk0VbMkyATIP5PUWPXZnZCJQYH+g13dCyAMh3fQXxwXD28nQSOpz3uASEUy9trauNPg=
X-Received: by 2002:ae9:c206:: with SMTP id j6mr14308398qkg.14.1566788006655;
 Sun, 25 Aug 2019 19:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190824210426.16218-1-katsuhiro@katsuster.net> <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
In-Reply-To: <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 26 Aug 2019 10:53:15 +0800
Message-ID: <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
> > This patch limits Headphone mixer volume to 4 from 7.
> > Because output sound suddenly becomes very loudly with many noise if
> > set volume over 4.

That sounds like something that should be limited in UCM.

> Higher then 4 not working matches my experience, see this comment from
> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>
> # Set HP mixer vol to -6 dB (4/7) louder does not work
> cset "name=3D'Headphone Mixer Volume' 4"

What does "does not work" mean more precisely?

I checked the spec, there is indeed something wrong in the kernel driver he=
re.
The db scale is not a simple scale as the kernel source suggests.

Instead it is:
0000 =E2=80=93 -12dB
0001 =E2=80=93 -10.5dB
0010 =E2=80=93 -9dB
0011 =E2=80=93 -7.5dB
0100 =E2=80=93 -6dB
1000 =E2=80=93 -4.5dB
1001 =E2=80=93 -3dB
1010 =E2=80=93 -1.5dB
1011 =E2=80=93 0dB

So perhaps we can fix the kernel to follow this table and then use UCM
to limit the volume if its too high on a given platform?

Thanks
Daniel
