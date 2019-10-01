Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3CC3A11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfJAQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:10:00 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:38312 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJAQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:10:00 -0400
Received: by mail-yw1-f46.google.com with SMTP id s6so5013812ywe.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rVNHxQBv3COxHhMQfRaJbsiP7eYBEtcANM45F8qCpHU=;
        b=Mv94PspYigl7q8wmgc5vXgkz1pxWmodiRXjtZIwuZy10JWWm6EQ47KE5CnnD6beSy/
         C6HPagwpcJvUl4IQZHud39oiNOzkrtsFHHy9sl4b2ZbHkbqmQF7u5p7EHbKzfHAbnD+e
         2Od1UHXavtM+a2oUn+EEAFMxAPO288yETwRZ7ZUx1zKLhLuG6u5ubED5csxPuQoCZZjS
         ydiDGMjXRoTf/hTlHnSCr1wD0s0GzX8nw+kVPTNa0slNzuAivsxBZq1DD1QOxKLsdnMR
         wC+35VeZp0POFXyNgX/IEdZgFU20SYRLggZ5TSLl+EmuPqzkwCFNg0ln3KSHbP4+glrm
         8YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rVNHxQBv3COxHhMQfRaJbsiP7eYBEtcANM45F8qCpHU=;
        b=ncDfYblA17VVJ3UFk2xyh0FEMAQH4BG1okQaRHi6NLHWGyqibzOWAbBGus8YzK0OtN
         hTzrLWcFUYeKFwph8SBx7C/zpt6DXB6dTWxWiM+tmsBZHjGlO/lNXQsQ5/C7T7O4O6ig
         MAcxmmAFstQQJAFLvZZh4QRfUuQyn0SXX0BqJbJzeCO3C0ihqPkeIMNK/JYLKL3QaB8d
         /PzLPervsVQnBWlHp5ehJ4Hfq4Dw/OiSwdta6dsjTmW9GZ9wRdqYz9c6j7p4hoI19xeB
         ou0yPuAWYfxwU40xfuDTAKU9pAwGtpzkcBxDPy2th8q3+VkswYAFZIt4Ea/lXs4s5O12
         cqHg==
X-Gm-Message-State: APjAAAXJvYh+QUEmJK8mN3jBAxBKNcI5kO57rDqGYcsWesrU2hHDhn1a
        rVYImjv2zvGGhGcfrF6u6FQPBtmvg+3tS45j0nTR2NEJr7PPlJ+2
X-Google-Smtp-Source: APXvYqzgnRQdx/qCST006QCqgkFgZVE4/eRmlQMSUuu+pBysIW8Hg9MW8MGgOGAs67oGA0G5jKFAN8iyWDE+pSCL1gA=
X-Received: by 2002:a81:3203:: with SMTP id y3mr9566155ywy.217.1569946197092;
 Tue, 01 Oct 2019 09:09:57 -0700 (PDT)
MIME-Version: 1.0
From:   Mat King <mathewk@google.com>
Date:   Tue, 1 Oct 2019 10:09:46 -0600
Message-ID: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
Subject: New sysfs interface for privacy screens
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending in plain text mode

I have been looking into adding Linux support for electronic privacy
screens which is a feature on some new laptops which is built into the
display and allows users to turn it on instead of needing to use a
physical privacy filter. In discussions with my colleagues the idea of
using either /sys/class/backlight or /sys/class/leds but this new
feature does not seem to quite fit into either of those classes.

I am proposing adding a class called "privacy_screen" to interface
with these devices. The initial API would be simple just a single
property called "privacy_state" which when set to 1 would mean that
privacy is enabled and 0 when privacy is disabled.

Current known use cases will use ACPI _DSM in order to interface with
the privacy screens, but this class would allow device driver authors
to use other interfaces as well.

Example:

# get privacy screen state
cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
enabled 0: privacy disabled

# set privacy enabled
echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state

 Does this approach seem to be reasonable?
