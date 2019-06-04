Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5446433C75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 02:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFDAcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 20:32:25 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46373 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:32:24 -0400
Received: by mail-vk1-f201.google.com with SMTP id y204so7217604vkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DkFNL0Lxas2CTOjiDN2hgVYuR42qb65M2nUWhRx2AoU=;
        b=jz0CqSLT9oPx/LNHm1SpggTbwu648KXundaKwR3Aku2A4C8KVccZQFhf2nuHxgu95m
         1JEttGtr7UV9L/k/dbvmWt+DG4/Rt7a3/9lTktxBnTH7kmFGK3lOX5CSVAU8Q7p6KXhd
         YjNOkCTGxr5rNC5s6YzwurA+rX/Fom/7Mz+e3CpGZgKthJoQXdYLl6Gtr/MA8E2mkSK0
         bnjs//ABbpsPpr+iADWMjYUnqMaSs6JByEqv8Gd8lhxLitoiQPwxMyTJnqQwtCyfPoQB
         KDswjYIcWec6OpTrhhM93e51hkI5eOpJILo8fMOwYqVNWQrFAUdFAnZC0kZE3YmK+7UU
         se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DkFNL0Lxas2CTOjiDN2hgVYuR42qb65M2nUWhRx2AoU=;
        b=Ag+VBQ8M4Sw6geHAHusiXUqBVqYwyil22XKcgy4mdgPspzCikIyK4BG31YbxlWUH9x
         pjHI8HtZiqN6CRij0Fmpk4IAKlOhwKkrK2mj/qzZtD9sjt2WwL9p3VyA7ybImHAPXcuh
         IPrtOIgTCUmjEiGrm95mN+Aq6vjYyytKA+q2ui30rvGbzrVonXynWKiBaVvJzufokBX5
         7ujKGJQ9tXOkvyU7ENrnzWSDB03lIRxI1opFrycZIVeaO3D3jpvCQSwj/psAKMPirKcJ
         C/UyHChMm/aDo88wx0zx9GoCerTJkgJWP2XT4MxfpZ94VnQh+phGgYbtxA9NBQeN8kFk
         1m3g==
X-Gm-Message-State: APjAAAX8QCVthub07Lo41/6JQUWtpKGhIeEc9whXnPdqYiXcNrpEz8L+
        /G8ykkMjcv8OEov/haUqHHTNr2UfJzJbqhM=
X-Google-Smtp-Source: APXvYqz//pvNugcA8Ub1+XgIlGN6l0nTsFMukZFYcAW+LoNM4NKtbt0/2oRDjBXSdd6HYKLROjJMWAUEL0hPELA=
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr12993229uar.109.1559608343365;
 Mon, 03 Jun 2019 17:32:23 -0700 (PDT)
Date:   Mon,  3 Jun 2019 17:32:13 -0700
Message-Id: <20190604003218.241354-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and optimize
 probe ordering
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic "depends-on" property that allows specifying mandatory
functional dependencies between devices. Add device-links after the
devices are created (but before they are probed) by looking at this
"depends-on" property.

This property is used instead of existing DT properties that specify
phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
is because not all resources referred to by existing DT properties are
mandatory functional dependencies. Some devices/drivers might be able
to operate with reduced functionality when some of the resources
aren't available. For example, a device could operate in polling mode
if no IRQ is available, a device could skip doing power management if
clock or voltage control isn't available and they are left on, etc.

So, adding mandatory functional dependency links between devices by
looking at referred phandles in DT properties won't work as it would
prevent probing devices that could be probed. By having an explicit
depends-on property, we can handle these cases correctly.

Having functional dependencies explicitly called out in DT and
automatically added before the devices are probed, provides the
following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just
  one consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, regulators providers, etc
  need to keep the resources they provide active and at a particular
  state(s) during boot up even if their current set of consumers don't
  request the resource to be active. This is because the rest of the
  consumers might not have probed yet and turning off the resource
  before all the consumers have probed could lead to a hang or
  undesired user experience.

  Some frameworks (Eg: regulator) handle this today by turning off
  "unused" resources at late_initcall_sync and hoping all the devices
  have probed by then. This is not a valid assumption for systems with
  loadable modules. Other frameworks (Eg: clock) just don't handle
  this due to the lack of a clear signal for when they can turn off
  resources. This leads to downstream hacks to handle cases like this
  that can easily be solved in the upstream kernel.

  By linking devices before they are probed, we give suppliers a clear
  count of the number of dependent consumers. Once all of the
  consumers are active, the suppliers can turn off the unused
  resources without making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier
devices to change the link when they probe.
 

Saravana Kannan (5):
  of/platform: Speed up of_find_device_by_node()
  driver core: Add device links support for pending links to suppliers
  dt-bindings: Add depends-on property
  of/platform: Add functional dependency link from "depends-on" property
  driver core: Add sync_state driver/bus callback

 .../devicetree/bindings/depends-on.txt        |  26 +++++
 drivers/base/core.c                           | 106 ++++++++++++++++++
 drivers/of/platform.c                         |  75 ++++++++++++-
 include/linux/device.h                        |  24 ++++
 include/linux/of.h                            |   3 +
 5 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/depends-on.txt

-- 
2.22.0.rc1.257.g3120a18244-goog

