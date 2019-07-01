Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE44A253
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfFRNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 09:35:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:36114 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfFRNfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:35:08 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 5C7B94E204B; Tue, 18 Jun 2019 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1560864907; bh=MT3CFRKGsj2MeUNMuZZstm1cs/HxYQ6CLk7N8FsW6TI=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=cshrEHKb8VA/3+BRVSbDe8LRiQ3m8Gb1GY0AphCO3iN90JSKdZIR1ZsNebFRTP9hp
         9lo0Y+2Q/S94BSR+QCMRKwRvGpLBwDZbIsaSLPNgzCyg0z1OzBOVL5jVb++h4k2W+3
         FieyPybvjGZ0EsbJRzg0FTsX0H/fH/eMp1KTu4xA=
To:     Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v16 0/3] Add support for the Purism Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Jun 2019 07:35:07 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
In-Reply-To: <20190618132009.GF1959@dragon>
References: <20190617135215.550-1-angus@akkea.ca>
 <20190618132009.GF1959@dragon>
Message-ID: <a4f077a86cbf6fa38b8d4c8079226abe@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-18 07:20, Shawn Guo wrote:
> On Mon, Jun 17, 2019 at 07:52:12AM -0600, Angus Ainslie (Purism) wrote:
>> Angus Ainslie (Purism) (3):
>>   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
>>   dt-bindings: Add an entry for Purism SPC
>>   dt-bindings: arm: fsl: Add the imx8mq boards
> 
> Applied all, thanks.

Thanks Shawn !

