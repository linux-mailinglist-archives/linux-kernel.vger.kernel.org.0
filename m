Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF6CDB79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJGFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 01:38:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:44162 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGFiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:38:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 22:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="222806536"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2019 22:38:21 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: dwc3: Switch to platform_get_irq_byname_optional()
In-Reply-To: <20191005210449.3926-3-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-3-hdegoede@redhat.com>
Date:   Mon, 07 Oct 2019 08:38:21 +0300
Message-ID: <87imp1ru7m.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Hans de Goede <hdegoede@redhat.com> writes:

> The dwc3 code to get the "peripheral" / "host" / "otg" IRQ first tries
> platform_get_irq_byname() and then falls back to the IRQ at index 0 if
> the platform_get_irq_byname().
>
> In this case we do not want platform_get_irq_byname() to print an error
> on failure, so switch to platform_get_irq_byname_optional() instead which
> does not print an error.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205037
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
