Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57284CB58F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfJDH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 03:59:18 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41211 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:59:18 -0400
Received: by mail-ed1-f54.google.com with SMTP id f20so4975665edv.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5yv5KZsUIb1/TqKbzmdWx5plLwHOTkXFlZjdLOR7hHY=;
        b=DYAjC35o+POrIYKXPtnArTUp/92oSxlf7ZzNGQMHJdkgBQOD+wX5UCf1udz5v2An17
         Fq6Ol+SljUObvqcMiVrEsqLZUeVxTFqNQlg1+lA128Du03gs0qxKM4QGQtgGcMInF1xK
         w9FzDsdoVRpPVzZnPKNocS2EaQsvWr9p4tuzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5yv5KZsUIb1/TqKbzmdWx5plLwHOTkXFlZjdLOR7hHY=;
        b=awnqBYp+1BPBqYJmexbv+Wu1t/LU8ErcgX1b/YdRYKeBtmy3F/L86aK0hmlTwkXy/G
         VqqdzdpelzgdBBzv7fmLC/68Kot/veJTvzvKmBgbCixmfVXXk51op7lhN1AHbxS2fHhS
         jddx0QdCuPk7e7gulQVkUxORTdgS3bfCOq3ADdJ6eXryDTAdo4mojarjbK+4NRswrNVc
         RUIjlBbsWVecdh3J7XC6OrCbUD0Qy1casAa5C0XDcGtiR1m7BGdqlt4QxncXrSGaSbyx
         4VHDwOPm3ckgB95h0aQkrMPBWjDYSy1jem7UKupqSFYbVx7IMsnfLK04koKh4bS8BpCk
         /FQA==
X-Gm-Message-State: APjAAAX11cv3TuLlMgvMhvlMDQGWumbfB6aMYL9YbPBu2JR1vV3qG03r
        ml0AfnPEC2s4in4yJHBvECwYhCqR8oKtkb2SuONJyCD6e0Y=
X-Google-Smtp-Source: APXvYqxY9dMcQhK57WddmzgPlIv7AEnBcQqE1PI4SzPvsPMymsaAyqSHt5+HpoyC4sP5Tuh/XA3LBms0QKMqNZK1RJo=
X-Received: by 2002:aa7:df8e:: with SMTP id b14mr13972033edy.65.1570175956000;
 Fri, 04 Oct 2019 00:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Gomez <daniel@qtec.com>
Date:   Fri, 4 Oct 2019 09:59:05 +0200
Message-ID: <CAH1Ww+RT=W9zhbv8A-gQscCPq5jWHOX3SFFeU07cXBngKH4C3Q@mail.gmail.com>
Subject: VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL: continuous frame interval
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, sakari.ailus@linux.intel.com
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are developing a v4l2 subdevice driver to be able to support the imx378
sensor and upstream it. But we would like to have a continuous frame
interval and the
current VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL ioctl implementation doesn't
support it.

How can we proceed here? Can we maybe add the limits by using the reserved area
of v4l2_subdev_frame_interval_enum struct? Something similar to
v4l2_subdev_frame_size_enum is doing with continuous frame size.

I guess it would also need to adapt v4l2-ctl, v4l2-compliance and so on but not
really sure about the whole impact in linuxtv/linux-media of this need.

Thanks in advance,
Daniel
