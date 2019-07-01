Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D716D44D38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfFMUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 16:16:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46174 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfFMUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:16:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so24066954qtn.13;
        Thu, 13 Jun 2019 13:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ndsFdJT5msH1jQIdsq/1aF4DNtPMQ+O2tUbOMazO1E=;
        b=VYjJuMIkLmYI3kNDts/JSA6QSvVU/Q4jepYQjweSR07q/S39O4UpkZxCPO3qroQNH+
         a+dkfpZ4pWJCLunWEqRKFBjKsqSisiSXPVfXu9ogrnQp/H3R+GxpAVn7kbyS1DR4Yu80
         wWUnEezZ6MylbsqC0NHao2G0InTUzjZW3vEcuWurRl8XjMbPLD0WtqgCAAlpSEvIPYaR
         H36BeCAXf44DxOmP1JlFWNsqoUsWOoZ7fg0dF+2SO9q+eowaiXLjinLtM1T3fmT6fFCF
         BqWlamDEqFoc0KqSpoAgEdCvIX5qJZLZUPPDLTO+cyLO1J+fiU/r70rpdKUsyu7LNp8j
         WDhw==
X-Gm-Message-State: APjAAAVuxJVa0erGsef6I3i+qvU3FU9MMCyQsZgEDq/fFSBZgEQIyt0n
        Ohkz6T/kvDUErPmTh0vbGg==
X-Google-Smtp-Source: APXvYqxyv4YC69ZgdCsc1cwzM2ITRQvAA59njwcfY8Nne0u37GVgVsXAmmt0JTZtsscGOKcJFLDrSw==
X-Received: by 2002:ac8:26d9:: with SMTP id 25mr39778211qtp.377.1560456993921;
        Thu, 13 Jun 2019 13:16:33 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id r17sm358498qtf.26.2019.06.13.13.16.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:16:33 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:16:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com,
        wahrenst@gmx.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, mpm@selenic.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: rng: Document BCM7211 RNG compatible
 string
Message-ID: <20190613201630.GA29776@bogus>
References: <20190510173112.2196-1-f.fainelli@gmail.com>
 <20190510173112.2196-2-f.fainelli@gmail.com>
 <ce516362-658f-cde3-9be8-0e092f554782@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce516362-658f-cde3-9be8-0e092f554782@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:57:49AM -0700, Florian Fainelli wrote:
> On 5/10/19 10:31 AM, Florian Fainelli wrote:
> > BCM7211 features a RNG200 block, document its compatible string.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Rob, does this look okay to you?

Yes, sorry, a bit behind on reviews.
