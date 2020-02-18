Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB86162F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgBRS64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:58:56 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53620 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:58:56 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D2D43200B16;
        Tue, 18 Feb 2020 18:58:54 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A26192096D; Tue, 18 Feb 2020 19:58:47 +0100 (CET)
Date:   Tue, 18 Feb 2020 19:58:47 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Souza, Jose" <jose.souza@intel.com>
Cc:     "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "s.zharkoff@gmail.com" <s.zharkoff@gmail.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>
Subject: Re: lockup on boot -- drm/i915/display: Force the state compute
 phase once to enable PSR
Message-ID: <20200218185847.GA15931@light.dominikbrodowski.net>
References: <20200217200942.GA2433@light.dominikbrodowski.net>
 <20200217220852.55cbac43@collabora.com>
 <20200218114821.GA2240@light.dominikbrodowski.net>
 <eb191e966bb4065239d413fd904684de24d37789.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb191e966bb4065239d413fd904684de24d37789.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:01:37PM +0000, Souza, Jose wrote:
> Hi
> 
> Yes this patch has a issue and we have a fix, I'm trying to find
> someone to review it, more information: 
> https://gitlab.freedesktop.org/drm/intel/issues/1151

Alas, that patch does not apply cleanly to -master.

Thanks,
	Dominik
