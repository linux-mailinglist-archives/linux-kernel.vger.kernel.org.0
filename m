Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB09D2883
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 13:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfJJL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 07:58:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:60507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfJJL6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:58:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 04:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="207177573"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 10 Oct 2019 04:58:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Oct 2019 14:58:39 +0300
Date:   Thu, 10 Oct 2019 14:58:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
Message-ID: <20191010115839.GC4981@kuha.fi.intel.com>
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191008140159.GC12909@kuha.fi.intel.com>
 <20191010083110.GA4981@kuha.fi.intel.com>
 <7730d466-53bc-c14a-120f-dcb91de1e973@redhat.com>
 <20191010111620.GB4981@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010111620.GB4981@kuha.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:16:23PM +0300, Heikki Krogerus wrote:
> In any case, do we leave this series as it is now, or should I add two
> patches to it - one that just removes device_connection_add/remove
> functions without any other changes, and another patch that removes
> that device_connection_find() function (together with generic_match
> etc.)?

Forget about it. Let's leave this series as it is now.

The device_connection_find() function we can remove separately.

thanks,

-- 
heikki
