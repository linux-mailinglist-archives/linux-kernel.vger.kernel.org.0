Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521A729975
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403970AbfEXNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 09:54:36 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34155 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:54:35 -0400
Received: by mail-pg1-f177.google.com with SMTP id h2so2064462pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnF7U0OApTQ5OcSla4k5LdCywdVaBBXmZsl+OyX6YdE=;
        b=0eOCD8Wh3erP0VxN9fq3F7XuUh8W3Q60OmYILVuvW753q5AxM+6DRIb0YINh9lqqSZ
         whyTwJCXtg4FPN7K1vCjg45vnem232BnXAzq0gvx12FSI/kP1ckZqbtnJdOTjgCaQ7LV
         PBFnNxQJsCKBN/XZN+keD0DA3Sgm0NqRjtdQJr4mhxnuP7C8VaKA5ZTkN9yNkSm7BSed
         sE7PEfzDm2Imv1AYigGnVVAtnkWTakZvi5NbwAINHfE0VEd4lWsa6WaQOyHG2oR1dFtJ
         Qdw+QrwerT07zGuIL1IZ5BQtJyptPUecxV4J2bot8c0iWuOto5+L8Tm0U0FaIfCpGeYu
         ZTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnF7U0OApTQ5OcSla4k5LdCywdVaBBXmZsl+OyX6YdE=;
        b=pVHpTq8H/DPzMit63fAhk0QbyhaOOz3TPgqYJqArH7X//cW5s1sFraIHq1QyHzYtbQ
         VkEeAEH3wazvLPqsVf29CMDc/u0lZjocGQ0l2sV4jW55XvsOWrIo31QrVJ+i8x37r5Nk
         MU1JJZUG7DMef+jtxDPAayB4XpadM3tjWmLTvCzm75Z3QreoYkMz93acNelnVfoNqclz
         hKXHYUvcbxZRLK5AHIZXc4/t/VplWU9lq4i4S8/0g2OZq/jPk9W7+pCZPzSup6JXatUd
         /ZfTEnuCoWgC+0buMBHGu3zez0bE5Ew8VC3PS10hzxIcxZ9UFXW+96yyKcdgo4WXukjy
         QK8g==
X-Gm-Message-State: APjAAAUkxZuG2BDcTjLF2Me8Ctk23nVBb4xPQpbYx5bD4wFcVxRrBnCW
        T3Nt+MuiRT6WXMVa0TY/7SKabjeABfYrIphf8kp+jw==
X-Google-Smtp-Source: APXvYqx0JufzY7qqejCL5Au4eE2SMC+Vt2RJArfZZMC+qiftz+e+44oYLdJZvtpW9XfyWZJ/UOpJHaIdOq+dZP+gRL4=
X-Received: by 2002:a63:d4c:: with SMTP id 12mr92953826pgn.30.1558706074731;
 Fri, 24 May 2019 06:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net> <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
 <20190523225219.GZ3274@piout.net>
In-Reply-To: <20190523225219.GZ3274@piout.net>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Fri, 24 May 2019 19:23:57 +0530
Message-ID: <CAG=yYwkhy5wTRywr5QUmGVQOED3EGQC8jFSCSj---TJfoyEhpw@mail.gmail.com>
Subject: Re: about selftests/rtc test related stuff
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 4:22 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> I just sent a fix for that timeout issue.

anyway thanks related to that
shall i  send a selftest fix that bail out in the test program  if the
user does not have root privileges ?

-- 
software engineer
rajagiri school of engineering and technology
