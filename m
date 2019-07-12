Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6189467155
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGLO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 10:28:58 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:48965 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfGLO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:28:58 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id lwXbhDbAL0SBqlwXehHyL1; Fri, 12 Jul 2019 16:28:56 +0200
Message-ID: <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jul 2019 16:28:36 +0200
In-Reply-To: <1562941185.3398.1.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
         <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
         <55f4d1c242d684ca2742e8c14613d810a9ee9504.camel@intel.com>
         <1562888433.2915.0.camel@HansenPartnership.com>
         <1562941185.3398.1.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMr2nDHN+vQMiu6ycsuxH9sUvGcaclwSB8gQFWemmcKnszoJckYcVA7kJ+kvBCwLWMikpWVChCEO0dy9CKeshRs3a8OtaRpEhZdt/s8ywdPX1z9AoXhz
 998M9aEHlttkUTsD5hrL5gDGtJdRJM9aVVlhSB6NZ+ddaJdyMVNA12r5xJyO2lBnYYyJGIHvJaM1tbdYYCW4Pp8OG+zB2OrX4kZxgcqHo85BjiyOgx0gcvqb
 bf0k0V0if2d3I5lYygVcZtmbfNDQWgujwup0icztT6BiXOoujJTa+5i7WuZbZUR3NJo6Rc0fOb3WMdw5aJc0FY3Sw2EOhnIPL3ivQ51TgIQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley schreef op vr 12-07-2019 om 07:19 [-0700]:
> It has survived 6h without manifesting the regression.  Starting again
> to try a whole day.

And I'm currently at four hours without a screen freeze. Which is much, much
longer than I was able to achieve without the hack applied.


Paul Bolle

