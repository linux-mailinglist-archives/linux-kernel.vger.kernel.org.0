Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D31B8C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395163AbfITIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 04:20:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35017 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391319AbfITIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:20:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so7739387qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SocQEUUMkK769LhW2Pd9m5ZQqfoBNJ10901hl/4ay4=;
        b=nLw1HL3elE8+Sl+dCKaY9ufcrvHnF8x33T1asuG5/yPil0hxbSfwf1Wp4ZcsEm9kKV
         6lBc0znEAm2vAWbqhqnMjBi3jZsfmj0teBImHoavMyHXPXWJLD7Xo5PowPkCZ+0hmZ9+
         fxnsAJQ9ihkQJZFVslAaafYyAx3QfmIinfhxhPiyCeb7Dv1hC5dobbi3BFuQZPljAiDH
         P+xA1GZFp6o4HDRHq2V9L8olN04Lwa7iz6Sn5JUH0GoA+zhoOq5FD+JEXu0/+RCc34nF
         yyCniL7e/t4BxT8qVfk8q76UZiA8iYPkAQqURVCTZc/oG72GX2Tl/Daro/+anIkcYmC9
         ST5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SocQEUUMkK769LhW2Pd9m5ZQqfoBNJ10901hl/4ay4=;
        b=kW+bbRBfA0akHtc8nBZW0TiyncZH2z4LT2uMlKZUNanZjnib2CA5Ftyb63powdig3F
         x2VR/metjBUSIqXzXBCwk2flM4aQuQDFok6O6zrh5chkXZuPbA27DoOhYXNtQRhTJrRG
         0q0EN6gPhdYqehyhmylQYn5Enp5iOq91hMzy+gznav9BQn59Cw/dedRpfZICuGd9U7eC
         g2zRdLDybgVy7XmKbdrPGO2BpjL9J6iADwKbdjPjWPllN5DS1JkyttM/d1aDjwuVuGyP
         /1l3+khURtEnRvrBskJ9aCQFSa/Yk/nVVRaSq6dmLrR9sNzNmb5yK7lifpLiojA6UlkL
         hMLw==
X-Gm-Message-State: APjAAAWgrPp9BY2rydMKptZFngetcBwtPioIFnuf608jGKU27mSxOr/C
        wFBimOQadnfkfu4Uw87YBWOdFPg7fR4f8UA+sEfk7A==
X-Google-Smtp-Source: APXvYqwlO5TN7aw8zddGqA6dfFkWBaGlE6Zgfrdslwr71Wxgag4BouCltVzFfmnE4S6FPXI8LDpPdjgihPX+lyfXNZQ=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr12063122qvo.146.1568967598534;
 Fri, 20 Sep 2019 01:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190920032437.242187-1-kyletso@google.com> <cb225c94-da97-1b47-48b6-3802dc3eb93b@redhat.com>
In-Reply-To: <cb225c94-da97-1b47-48b6-3802dc3eb93b@redhat.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 20 Sep 2019 16:19:42 +0800
Message-ID: <CAGZ6i=3O2zLJMPY5UevjTrJJj7fxpWcn28dZYRptWES74=4Tgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

I have tested these on an Android device (ARM64).
All the swap operations work fine (Power Role/Data Role/Vconn Swap).
(except for Fast Role Swap because it is still not supported in TCPM)

Regards,
Kyle Tso


On Fri, Sep 20, 2019 at 4:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kyle,
>
> On 20-09-2019 05:24, Kyle Tso wrote:
> > *** BLURB HERE ***
> >
> > Kyle Tso (2):
> >    usb: typec: tcpm: AMS and Collision Avoidance
> >    usb: typec: tcpm: AMS for PD2.0
>
> May I ask how and on which hardware you have tested this?
>
> And specifically if you have tested this in combination with pwr-role swapping?
>
> Regards,
>
> Hans
>
